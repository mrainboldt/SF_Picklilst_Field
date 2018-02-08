({
	init : function(component, event, helper){
		helper.init(component, event);
	},
 
	/**
	* Select an SObject from a list
	*/
	select: function(component, event, helper) {
		helper.doSelection(component, event);
	},

})