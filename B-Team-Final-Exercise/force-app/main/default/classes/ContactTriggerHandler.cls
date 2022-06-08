public with sharing class ContactTriggerHandler {
    public static void beforeUpdate(Map<Id,Contact> oldRecords, List<Contact> newRecords) {
        ContactServiceLayer.updateFields(oldRecords, newRecords);
    }
}