//Standard Controller Extension - to display the Invoice Line Items along with Invoice Details
public with sharing class InvoiceExtension {
    //Model to store all related Invoice Line Item
    public List<Invoice_Line_Item__c> invlList {get;set;}
    /*
    public List<Invoice_Line_Item__c> getInvoiceList(){
        return this.invlList;
    }
    public void setInvoiceList(List<Invoice_Line_Item__c> value){
        this.invlList= value;
    }
    */

    public InvoiceExtension(Apexpages.StandardController sc) {
        //Get the current Invoice record
        Invoice__c invoiceRec = (Invoice__c)sc.getRecord(); //Returns SObject, so downcast SObject to Invoice__c object
        
        //Fetch all Invoice Line Item records for the current Invoice record
        invlList = [SELECT Id, Name, Price__c from Invoice_Line_Item__c WHERE Invoice_Master__c = :invoiceRec.Id];
    }
}