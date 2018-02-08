({
	init : function(component, event) {
		this.getOptions(component,event);

	},

	getOptions : function(component, event){
		var action = component.get("c.getOptions");
        action.setParams({
            "objectName" : component.get("v.sObjectAPIName")
            ,"fieldName" : component.get("v.field")
        });
    	action.setCallback(this,function(response) {
    		var state = response.getState();
        	if (component.isValid() && state === "SUCCESS") {
       			component.set("v.options", response.getReturnValue());
        	}else{
        		this.processErrors(component, response,"Error: ", "error");
        	}
		});
    	$A.enqueueAction(action);
	},

	doSelection : function(component, event){
		// Create the ClearLookupId event
		var updateEvent = component.getEvent("updatePicklistEvent");

		// Fire the event
		updateEvent.fire();
	},

	processErrors : function(component, response, title, type){
		var messages = [];
		var errors = response.getError();
		if(errors[0].message){
			messages.push(errors[0].message);
		}
        for(var key in errors[0].fieldErrors){
            messages.push(errors[0].fieldErrors[key].message);	
        }
        for(var key in errors[0].pageErrors){
            messages.push(errors[0].pageErrors[key].message);	
        }
        var message = "";
        for(var key in messages){
        	if(message){
        		message += "\r\n";
        	}
        	message += messages[key];
        }
        this.showToast(component, title, message, type);
        
	},

    showToast: function(component, title, message, type){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type,
            "mode": "sticky"
        });
        toastEvent.fire();	
    }
})