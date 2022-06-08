public with sharing class ContactServiceLayer {
    public static void updateFields (Map<Id,Contact> oldRecords, List<Contact> newRecords) {
        for (Contact cont: newRecords) {
            //Here we use the contact id, to get the older version of the record.
            Contact oldContact = oldRecords.get(cont.Id);    
            //once we get the older version, we can get any field's value from older version to compare.
            if(cont.AccountId != oldContact.AccountId) {
                cont.LastEditorType__c = cont.LastModifiedById;
                cont.LastEditorDateType__c = DateTime.now();
                System.debug('LastEditorTypes is updated');
            }
        }
    }
}