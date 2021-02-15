public with sharing class AllInvoiceController {
    //Get all the Invoice records
    @AuraEnabled
    public static List<Invoice__c> getAllInvoice(){
        List<Invoice__c> invoiceList = new List<Invoice__c>();
        invoiceList = [SELECT Id, Name from Invoice__c];
        return invoiceList;
    }
    //Get Invoice and INVL list records for the passed invoice record Id
    @AuraEnabled
    public static InvoiceResponse getInvoiceDetails(Id invoiceId){
        InvoiceResponse response = new InvoiceResponse();
        response.invoiceRecord =[SELECT Id, Name, Price__c, Status__c from Invoice__c WHERE Id =:invoiceId];
        response.invlList = [SELECT Id, Name, Price__c from Invoice_Line_Item__c WHERE Invoice_Master__c=:invoiceId];
        return response;
    }
    //Inner class - Used as sending response back to browser
    public class InvoiceResponse{
        public Invoice__c invoiceRecord;
        public List<Invoice_Line_Item__c> invlList;
    }
}