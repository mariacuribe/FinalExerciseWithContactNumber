@isTest
public with sharing class TestDataFactory {
    public static List<Account> createAccounts(Integer numAccts, Integer numContPerAcct) {
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        List<Contact> conts = new List<Contact>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add contacts
            for (Integer k=0;k<numContPerAcct;k++) {
                conts.add(new Contact(FirstName=acct.Name+' Contact ' + k, LastName = 'Test', AccountId=acct.Id));
            }
        }
        // Insert all contacts for all accounts.
        insert conts;
        return accts;
    }
}