public with sharing class InvoiceController {
	@AuraEnabled
    public static List<Invoice__c> getAllInvoice(){
        return [SELECT Id, Name, Status__c FROM Invoice__c];
    }
}