// Component with custom controller
public with sharing class InvoiceDetailWithINVLController {
    //Method will be annotated with AuraEnabled, so it'll be called by Lightning Component and fetch Invoice and Invoice Line Item, return back to browser
    @AuraEnabled
    public static InvoiceResponse getInvoiceWithInvl(Id invoiceId) {
        InvoiceResponse invResponse = new InvoiceResponse();
        //Get the current Invoice record
        invResponse.invoiceRec =[SELECT Id, Name, Billing_Date__c, Status__c, Price__c, Max_INVL_Price__c, Min_INVL_Price__c, Invoice_External_Id__c, Account__c, Owner_Profile_Name__c, Country__c, State__c, City__c, Street__c FROM Invoice__c WHERE Id =:invoiceId]; //Returns SObject, so downcast SObject to Invoice__c object
        
        //Fetch all Invoice Line Item records for the current Invoice record
        invResponse.invlList = [SELECT Id, Name, Price__c, Status__c from Invoice_Line_Item__c WHERE Invoice_Master__c = :invoiceId];
        //return the response to the lightning component
        return invResponse;
    }

    //Inner class - to hold the response send back to the browser
    public class InvoiceResponse{
        //Annotate the variables with AuraEnabled, so it'll be sent as response to Lightning component
        @AuraEnabled
        public Invoice__c invoiceRec;
        @AuraEnabled
        public List<Invoice_Line_Item__c> invlList;
    }
}