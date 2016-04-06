@isTest
public class CRIT_DirectorySearchComponentTest {
    
    @testSetup 
    static void setup()
    {
		Contact testContact = new Contact();
        
        testContact.FirstName = 'Blahbert';
        testContact.LastName = 'Blahberttington';
        testContact.Email = 'testuser@example.com';
        testContact.Department = 'Brand New Dept';
        testContact.Phone = '312-555-1212';
        testContact.IsActiveEmployee__c = true;
        
        insert testContact;
    }
    
    static testMethod void doSearchTest()
    {
		Map<String,String> searchQuery = new Map<String,String>();
        searchQuery.put('name', 'blah');
        List<Contact> resultsList = CRIT_DirectorySearchComponent.getSetOfContacts(searchQuery);
        System.debug(resultsList);
    }
    
    static testMethod void queryBuildingTest()
    {
		Map<String,String> mockJSObject = new Map<String,String>();
        mockJSObject.put('name', 'blah');
        mockJSObject.put('PHONE', '3333'); // class should compare by lowercase
        mockJSObject.put('dept', 'blah');
        mockJSObject.put('email', 'blah');
        mockJSObject.put('sortOrder', 'ASC');
        mockJSObject.put('sortBy', 'Name');

        String returnedQuery = CRIT_DirectorySearchComponent.getQueryForSearch(mockJSObject);
        String expectedQuery = 'SELECT Name, Phone, DirectoryPublicPhone__c, DirectoryWorkPhone__c, Email, Title, Department FROM Contact  WHERE Id <> \'\'  AND Name like \'%blah%\'  AND Phone like \'%3333%\'  AND Department like \'%blah%\'  AND Email like \'%blah%\'  AND IsActiveEmployee__c = true  ORDER BY PrimaryLastName__c ASC ';

        System.debug(returnedQuery);
        System.assertEquals(returnedQuery, expectedQuery );

    }



}