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
        
        String orderField = ' PrimaryLastName__c ';
        String orderDirection = ' DESC ';

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

                //Figure out the ORDER BY clause
                //Note that we can only search by one field at a time.
                if (key.toLowerCase() == 'sortBy' && searchFields.get(key) != '')
                {
                    //options 'Name', 'Phone', 'Dept', 'Title', 'Email'
                    if (searchFields.get(key) == 'Name')
                    {
                        orderField = 'PrimaryLastName__c';
                    }
                    if (searchFields.get(key) == 'Phone')
                    {
                        orderField = 'DirectoryWorkPhone__c';
                    }
                    if (searchFields.get(key) == 'Dept')
                    {
                        orderField = 'Department';
                    }
                    if (searchFields.get(key) == 'Title')
                    {
                        orderField = 'Title';
                    }
                    if (searchFields.get(key) == 'Email')
                    {
                        orderField = 'Email';
                    }
                }
                if (key.toLowerCase() == 'sortOrder' && searchFields.get(key) != '')
                {
                    if (searchFields.get(key) == 'DESC')
                    {
                        orderDirection = ' DESC ';
                    }else
                    {
                        orderDirection = ' ASC ';
                    }
                }
            } 
        String orderByClause = ' ORDER BY ' + orderField + orderDirection;
        String queryString = 'SELECT Name, Phone, DirectoryPublicPhone__c, DirectoryWorkPhone__c, Email, Title, Department FROM Contact ' +  whereClause + ' AND IsActiveEmployee__c = true ' + orderByClause;
        return queryString;
    }
}