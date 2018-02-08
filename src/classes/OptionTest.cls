@isTest
private class OptionTest{
	@isTest
	static void test_Constructor(){
		//Arrange
		String label = 'label'; 
		String value = 'value'; 
		Boolean isDefault = false;

		//Act
		test.startTest();
		Option result = new Option(label, value, isDefault);
		test.stopTest();

		//Assert
		System.assertNotEquals(null, result);
		System.assertEquals(label, result.label);
		System.assertEquals(value, result.value);
		System.assertEquals(isDefault, result.isDefault);

	}
}