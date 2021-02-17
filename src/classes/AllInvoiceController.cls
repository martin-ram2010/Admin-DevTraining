public with sharing class AllInvoiceController {
    //Get all the Invoice records
    @AuraEnabled
    public static List<Invoice__c> getAllInvoice(){
        List<Invoice__c> invoiceList = new List<Invoice__c>();
        invoiceList = [SELECT Id, Name from Invoice__c];
        return invoiceList;
    }

    //Get INVL list records for the passed invoice record Id
    @AuraEnabled
    public static List<Invoice_Line_Item__c> getInvoiceLineItems(Id invoiceId){
        return [SELECT Id, Name, Price__c, Status__c from Invoice_Line_Item__c WHERE Invoice_Master__c=:invoiceId];
    }
    
    //Get Invoice Record records for the passed invoice record Id
    @AuraEnabled
    public static Invoice__c getInvoiceRecord(Id invoiceId){
        Invoice__c invoiceRecord = [SELECT Id, Name, Status__c, Price__c FROM Invoice__c WHERE Id =: invoiceId];
        return invoiceRecord;
    }
}