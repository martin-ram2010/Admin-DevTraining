//Define custom INVL REST Webservice to update INVL records
@RestResource(urlMapping='/invl/v1/*')
global with sharing class InvlRESTWebservice {
    //Update INVL record based on INVL_External_Id__c field 
    //Method will be invoked by external system through REST callout using POST method
    @HttpPost
    global static List<INVLResponse> updateInvoiceLineItems(List<InvoiceLineItem> incomingInvlRecords) { //[{"status":null,"price":null,"name":null,"externalId":null}]
        
        List<INVLResponse> responseList = new List<INVLResponse>();
        //Access the incoming Request
        RestRequest req = RestContext.request;
        System.debug(req.headers);
        RestResponse outgoingRestResponse = RestContext.response;
        outgoingRestResponse.setHeader('Content-Type', 'application/json');

        //Process incoming payload and instantiate Invoice_Line_Item__c SObject
        List<Invoice_Line_Item__c> upsertInvlList = new List<Invoice_Line_Item__c>();
        for(InvoiceLineItem invl : incomingInvlRecords){
            Invoice_Line_Item__c lineItemRecord = new Invoice_Line_Item__c(INVL_External_Id__c = invl.externalId, Name = invl.name, Status__c = invl.status, Price__c = invl.price );
            upsertInvlList.add(lineItemRecord);
        }
        //Update Invoice_Line_Item__c records and send back the update result back to client
        if(!upsertInvlList.isEmpty()){
            List<Database.UpsertResult> upsertResults = Database.upsert(upsertInvlList, Invoice_Line_Item__c.INVL_External_Id__c,false);
            for(Integer i=0; i< upsertResults.size(); i++){
                Database.UpsertResult result =upsertResults[i];
                String message;
                if(result.isSuccess()){
                    message='success';
                }else{
                    message =result.getErrors()[0].getMessage();
                }
                INVLResponse response = new INVLResponse();
                //External Id will be recognized by Server and client system, but not record id
                response.externalId = upsertInvlList[i].INVL_External_Id__c;
                response.message = message;
                responseList.add(response);
            }
        }
        return responseList;
    }

    global class InvoiceLineItem {
        global String externalId;
        global String name;
        global String status;
        global Decimal price;
    }
    global class INVLResponse{
        global String externalId;
        global String message;
    }
}