@isTest
private class PicklistSObjectControllerTest{
	private static String objectName = 'Account';
	private static String fieldName ='Rating';
	private static Integer optionCount;

	@testSetup
	static void setup(){
		SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        Map<String,Schema.SObjectField> mfields = objType.getDescribe().fields.getMap();
        
        Schema.DescribeFieldResult fieldResult = mfields.get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        optionCount = ple.size();
	}

	@isTest
	static void test_getOptions_Success(){
		//Arrange
		setup();
		
		//Act
		test.startTest();
		Option[] results = PicklistSObjectController.getOptions(objectName, fieldName);
		test.stopTest();


		//Assert
		System.assertEquals(optionCount + 1, results.size());

	}

	@isTest
	static void test_getOptions_Exception_objectName(){
		//Arrange

		//Act
		test.startTest();
		String message;
		Option[] results;
		try{
			results = PicklistSObjectController.getOptions(null, fieldName);
		}catch(Exception e){
			message = e.getMessage();
		}
		
		test.stopTest();

		//Assert
		System.assertEquals(null, results);
		System.assertEquals('An object name must be provided to get picklist values.', message);

	}

	@isTest
	static void test_getOptions_Exception_fieldName(){
		//Arrange

		//Act
		test.startTest();
		String message;
		Option[] results;
		try{
			results = PicklistSObjectController.getOptions(objectName, null);
		}catch(Exception e){
			message = e.getMessage();
		}
		
		test.stopTest();

		//Assert
		System.assertEquals(null, results);
		System.assertEquals('A field name must be provided to get picklist values.', message);

	}
}