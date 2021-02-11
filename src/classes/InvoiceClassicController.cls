//Custom Controller
public with sharing class InvoiceClassicController {
    public List<Invoice__c> invoiceList {get;set;}
    public List<Invoice_Line_Item__c> invlList {get;set;}
    public Invoice__c invoiceRec {get;set;}
    public Id selecteInvoiceId {get;set;}

    //Constructor
    public InvoiceClassicController() {
        System.debug('InvoiceClassicController constructor');
        invoiceList =[SELECT Id, Name, Billing_Date__c, Price__c FROM Invoice__c];

    }
    //To fetch the complete detail of Invoice and related Invoice Line Item records
    public void getInvoiceRelatedDetails(){
        System.debug('selecteInvoiceId:'+selecteInvoiceId);
        invoiceRec =[SELECT Id, Name, Billing_Date__c, Status__c, Price__c, Max_INVL_Price__c, Min_INVL_Price__c, Invoice_External_Id__c, Account__c, Owner_Profile_Name__c, Country__c, State__c, City__c, Street__c FROM Invoice__c WHERE Id =:selecteInvoiceId];
        //Fetch all Invoice Line Item records for the current Invoice record
        invlList = [SELECT Id, Name, Price__c from Invoice_Line_Item__c WHERE Invoice_Master__c = :selecteInvoiceId];
    }
}