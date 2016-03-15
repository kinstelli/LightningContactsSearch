({
	doSearch : function(component, event, helper)
	{

		var queryMap = 
        {
            name: component.get('v.nameSearch'),
            phone: component.get('v.phoneSearch'),
            email: component.get('v.emailSearch'),
            dept: component.get('v.deptSearch'),
            title: component.get('v.titleSearch')
       	};
    	console.log(queryMap);
        
        var actionToGetContacts = component.get("c.getSetOfContacts"); // call Apex Class
        actionToGetContacts.setParams({searchFields: queryMap});
	    actionToGetContacts.setStorable();
        actionToGetContacts.setCallback(this, function(result) 
    	{
            component.set("v.foundContacts", result.getReturnValue()); // set View variable
        	component.set("v.spinnerOverlay", false);

    	});

    	component.set("v.spinnerOverlay", true);
        $A.enqueueAction(actionToGetContacts);
	}
})