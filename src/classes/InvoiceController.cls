public with sharing class InvoiceController {
    public static Boolean flag=true;
	@AuraEnabled
    public static List<Invoice__c> getAllInvoice(){
        if(flag){
            
        }else{
            Invoice__c inv = new Invoice__c();
        }
        return [SELECT Id, Name, Status__c FROM Invoice__c];
    }
    @AuraEnabled
    public static List<Invoice__c> getAllInvoice2(){
        return [SELECT Id, Name, Status__c FROM Invoice__c];
    }
}