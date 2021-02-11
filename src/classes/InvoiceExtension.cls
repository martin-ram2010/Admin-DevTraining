//Standard Controller Extension - to display the Invoice Line Items along with Invoice Details
public with sharing class InvoiceExtension {
    public List<Invoice_Line_Item__c> invlList {get;set;}

    public InvoiceExtension(Apexpages.StandardController sc) {
        //Get the current Invoice record
        Invoice__c invoiceRec = (Invoice__c)sc.getRecord(); //Returns SObject, so downcast SObject to Invoice__c object
        
        //Fetch all Invoice Line Item records for the current Invoice record
        invlList = [SELECT Id, Name, Price__c from Invoice_Line_Item__c WHERE Invoice_Master__c = :invoiceRec.Id];
    }
}