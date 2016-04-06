({
	doSearch : function(component, event, helper)
	{
        //debugger;
		var queryMap = 
        {
            name: component.get('v.nameSearch'),
            phone: component.get('v.phoneSearch'),
            email: component.get('v.emailSearch'),
            dept: component.get('v.deptSearch'),
            title: component.get('v.titleSearch'),
            sortBy: component.get('v.sortBy'),
            sortOrder: component.get("v.sortOrder")
       	};
        console.log("Here is what is being sent...");
    	console.log(queryMap);
        
        var actionToGetContacts = component.get("c.getSetOfContacts"); // call Apex Class
        actionToGetContacts.setParams({searchFields: queryMap});
	    //actionToGetContacts.setStorable();
        actionToGetContacts.setCallback(this, function(result) 
    	{
           // console.log("Found...");
           // console.log(result.getReturnValue());
            component.set("v.foundContacts", result.getReturnValue()); // set View variable
        	component.set("v.showSpinnerOverlay", false);
    	});
    	component.set("v.showSpinnerOverlay", true);


        $A.enqueueAction(actionToGetContacts);
	}, 
    handleSortChange: function(component, sortName)
    {
        var curSort = component.get("v.sortBy");
        var curSortDesc = component.get("v.sortOrder");

        if (sortName === curSort)
        {
            //just toggle the sort order
            if (curSortDesc === 'DESC')
            {
                component.set("v.sortOrder", 'ASC');
            }else{
                component.set("v.sortOrder", 'DESC');
            }
        }else{
            component.set("v.sortBy", sortName);
        }
    },
    validateMinimalSearchCriteria: function(component)
    {
        //debugger;
        var nameSearchVal = component.get('v.nameSearch');
        var phoneSearchVal =  component.get('v.phoneSearch');
        var emailSearchVal =  component.get('v.emailSearch');
        var deptSearchVal =  component.get('v.deptSearch');
        var titleSearchVal =  component.get('v.titleSearch');

        var lengthOfAll = (nameSearchVal.length + phoneSearchVal.length  +  emailSearchVal.length + deptSearchVal.length +  titleSearchVal.length);
        //TODO: this is *one* way to limit searches. Not sure if it's the best way
        if (lengthOfAll > 2)
        {
            return true;
        }
        return false;
    }

})