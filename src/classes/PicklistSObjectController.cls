public with sharing class PicklistSObjectController {

	@AuraEnabled
    public static Option[] getOptions(String objectName, String fieldName){
        if(String.isBlank(objectName)){
            throw new PicklistException('An object name must be provided to get picklist values.');
        }

        if(String.isBlank(fieldName)){
            throw new PicklistException('A field name must be provided to get picklist values.');
        }

        SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        Map<String,Schema.SObjectField> mfields = objType.getDescribe().fields.getMap();


        List<Option> options = new List<Option>();
        //String[] options = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = mfields.get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new Option('--None--','', false));
        for( Schema.PicklistEntry f : ple){
            System.debug(f);
            if(!f.isActive()) continue;
            options.add(new Option(f.getLabel(), f.getValue(),f.isDefaultValue()));
        }       
        return options;
    }

    public class PicklistException extends Exception{}
}