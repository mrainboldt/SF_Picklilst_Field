public class Option {
	@AuraEnabled public String label {get; set;}
	@AuraEnabled public String value {get; set;}
	@AuraEnabled public Boolean isDefault {get; set;}

	public Option(String label, String value, Boolean isDefault) {
		this.label = label;
		this.value = value;
		this.isDefault = isDefault;
	}
}