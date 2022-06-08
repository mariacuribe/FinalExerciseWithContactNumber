trigger Contact on Contact (before update) {
	ContactTriggerHandler.beforeUpdate(Trigger.oldMap, Trigger.new);
}