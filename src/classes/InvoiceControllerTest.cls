@isTest
public class InvoiceControllerTest {
	@isTest
    static void testGetAllInvoice(){
        //Create Test Data
        Invoice__c invoiceRec = new Invoice__c();
        invoiceRec.Name='John';
        invoiceRec.Status__c = 'New';
        invoiceRec.Street__c ='Salesforce Street';
        insert invoiceRec; //DML 1 out of 150
        
        Test.startTest();//Reset all Governor Limits, for Eg: DML 0 out of 150
        //Success or positive scenario
        List<Invoice__c> invoiceList = InvoiceController.getAllInvoice();//SOQL 1 out of 100
        System.assertEquals(1, invoiceList.size());
        //Negative or else scenario
        InvoiceController.flag=false;
        invoiceList = InvoiceController.getAllInvoice();//SOQL 1 out of 100
        Test.stopTest();
        //SOQL 0 out of 100
    }
    @isTest
    static void testGetAllInvoice2(){
        //Create Test Data
        Invoice__c invoiceRec = new Invoice__c();
        invoiceRec.Name='John';
        invoiceRec.Status__c = 'New';
        invoiceRec.Street__c ='Salesforce Street';
        insert invoiceRec; //DML 1 out of 150
        
        Test.startTest();//Reset all Governor Limits, for Eg: DML 0 out of 150
        List<Invoice__c> invoiceList = InvoiceController.getAllInvoice2();//SOQL 1 out of 100
        System.assertEquals(1, invoiceList.size());
        Test.stopTest();
        //SOQL 0 out of 100
    }
}