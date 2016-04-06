({
	handleSearchChange : function(component, event, helper) {
		//reset array to nothing, regardless
		component.set("v.foundContacts", []);
		
		if (helper.validateMinimalSearchCriteria(component) )
		{
			helper.doSearch(component, event, helper);
		}
	},
	handleHeaderClick : function(component, event, helper)
	{
		sortName = event.target.value;
		console.log("sort name:" + sortName);
		helper.handleSortChange(component, sortName);

		if (helper.validateMinimalSearchCriteria(component) )
		{
			helper.doSearch(component, event, helper);
		}
	}
	
});