({
	handleSearchChange : function(component, event, helper) {

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
			helper.doSearch(component, event, helper);
		}else if (lengthOfAll === 0)
		{
			component.set("v.foundContacts", []);
		}
	},
	handleHeaderClick : function(component, event, helper)
	{
		sortName = event.target.value;
		console.log("sort name:" + sortName);
		helper.handleSortChange(component, sortName);

		helper.doSearch(component, event, helper);
	}

});