@isTest
public with sharing class ContactTriggerTestClass {
    @isTest 
    static void TestUpdateFields() {
        // Test data setup
        // Create two accounts with contacts, and then change the related account
        Account[] accts = TestDataFactory.createAccounts(2,1);
        Contact contacto = [SELECT 
        Id,
        Name,
        AccountId,
        LastEditorType__c,
        LastEditorDateType__c
        FROM Contact
        WHERE AccountId=:accts[0].Id];
        // Perform test
        Test.startTest();
        contacto.AccountId = accts[1].Id;
        update contacto;
        Test.stopTest();
        // Verify that fields LastEditorType and LastEditorDateType were changed
        contacto = [SELECT 
        Id,
        Name,
        AccountId,
        LastEditorType__c,
        LastEditorDateType__c
        FROM Contact
        WHERE AccountId=:accts[1].Id
        ORDER BY LastModifiedDate Desc 
        LIMIT 1];
        system.assert(contacto.LastEditorType__c  != null);
        system.assert(contacto.LastEditorDateType__c != null);
    }
}