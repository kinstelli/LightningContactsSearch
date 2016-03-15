public with sharing class CRIT_DirectorySearchComponent {
	
    @AuraEnabled
    public static List<Contact> getSetOfContacts(Map<String,String> searchFields)
    {
		List<Contact> contactList = new List<Contact>();
        String contactsQuery = getQueryForSearch(searchFields);

        try {
            contactList = database.query(contactsQuery);
        }catch(DMLException dlme)
        {
            
        }catch(Exception e)
        {
            
        }
        return contactList;
    }

    public static String getQueryForSearch(Map<String,String> searchFields)
    {
        String whereClause = ' WHERE Id <> \'\' ';
            for (String key : searchFields.keySet()) 
            {
                System.debug('key:' + key + '  and value:' + searchFields.get(key)  );
                
                if ( key.toLowerCase() == 'name' && searchFields.get(key) != '')
                {
                    whereClause += ' AND Name like \'%' + String.escapeSingleQuotes(searchFields.get(key)) + '%\' ';
                }
                if ( key.toLowerCase() == 'phone' && searchFields.get(key) != '')
                {
                    whereClause += ' AND Phone like \'%' + String.escapeSingleQuotes(searchFields.get(key)) + '%\' ';
                }
                if ( key.toLowerCase() == 'email' && searchFields.get(key) != '')
                {
                    whereClause += ' AND Email like \'%' + String.escapeSingleQuotes(searchFields.get(key)) + '%\' ';
                }
                if ( key.toLowerCase() == 'dept' && searchFields.get(key) != '')
                {
                    whereClause += ' AND Department like \'%' + String.escapeSingleQuotes(searchFields.get(key)) + '%\' ';
                }
                if ( key.toLowerCase() == 'title' && searchFields.get(key) != '')
                {
                    whereClause += ' AND Title like \'%' + String.escapeSingleQuotes(searchFields.get(key)) + '%\' ';
                }
            } 
        String queryString = 'SELECT Name, Phone, Email, Title, Department FROM Contact ' +  whereClause + ' AND IsActiveEmployee__c = true ORDER BY PrimaryLastName__c';
        return queryString;
    }
}