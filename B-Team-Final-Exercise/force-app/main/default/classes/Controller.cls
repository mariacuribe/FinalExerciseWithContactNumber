public with sharing class Controller {
    //Method to get accounts and populate contactCount field that shows the amount of contacts in an account
    @AuraEnabled (cacheable=true)
    public static List<Account> getAccounts () {
        List<Account> accounts = [
            SELECT 
            Id,
            Name,
            contactCount__c
            FROM Account
        ];
        // for (Account record : accounts) {
        //     Integer count = [
        //     SELECT 
        //      COUNT()
        //      FROM Contact
        //      WHERE AccountId = :record.Id
        //  ];
        //     record.contactCount__c=count;
        // }
        return accounts;
    }

    //Method to get contacts from an account
    @AuraEnabled 
    public static List<Contact> getContacts (String clickAccountId) {
        List<Contact> contacts = [
            SELECT 
            Id,
            Name
            FROM Contact
            WHERE AccountId=:clickAccountId
        ];
        return contacts;
    }

    //Method to get number of contacts in an account
    @AuraEnabled
    public static List<AggregateResult> getContactsNumber(){
        List<AggregateResult> res = [SELECT COUNT(Id) Conteo, AccountId  FROM Contact GROUP BY AccountId];
        return res;
    }
}