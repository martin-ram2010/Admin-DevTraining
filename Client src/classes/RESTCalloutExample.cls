public inherited sharing class RESTCalloutExample {
    public static final String USERNAME ='admintrainer@2021.com';
    public static final String PASSWORD ='start042021';
    public static final String SECURITY_TOKEN ='wbS1phS3b13LqhGLgPwRLDoNm';
    public static final String CLIENT_ID='3MVG9fe4g9fhX0E6CPostqgMrB.DB.98pYL_78A0p2.3plZsqIfDiOQjFhXma1OTVs5Oaxsev17VnVzlICYON';
    public static final String CLIENT_SECRET='BEB3861F9CEE2B9402C4BC257005E03D4C2BD18B0254CC18EBC542D00A7F6D76';
    public static final String AUTH_ENDPOINT='https://login.salesforce.com';
    
    //To deserialize the received Authentication JSON object into Apex class
    public class JSONObject{
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
    //call method to get the accesstoken with redirect URI
    public static JSONObject oAuthLogin(){
        //Create a HttpRequest
        HttpRequest req=new HttpRequest();
        req.setMethod('POST');
        //The content type you're sending in the form of application/x-www-form-urlencoded
        // req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setEndpoint(AUTH_ENDPOINT+'/services/oauth2/token');
        req.setBody('grant_type=password'+
                   '&client_id='+CLIENT_ID+
                   '&client_secret='+CLIENT_SECRET+
                   '&username='+USERNAME+
                   '&password='+PASSWORD);
        System.debug('Encoded Username:'+EncodingUtil.urlEncode(USERNAME, 'UTF-8'));
        System.debug('Encoded Password:'+EncodingUtil.urlEncode(PASSWORD, 'UTF-8'));
        
        Http http=new Http();
        //HttpRequest is prepared, now make the callout with request by calling HTTP.send()
        HttpResponse res=http.send(req);
        //Received the Access Token details as JSON object
        System.debug('Response Body:'+res.getBody());
        System.debug('Status:'+res.getStatus());
        System.debug('Status Code:'+res.getStatusCode());
        
        return (JSONObject)JSON.deserialize(res.getBody(), JSONObject.class);
    }

    @future(callout=true) //To make the callout asynchronously
    public static void syncInvl(String payLoad){
        try{
            JSONObject jsonObj=oAuthLogin();
            String accessToken=jsonObj.access_token;
            String instanceUrl=jsonObj.instance_url;
        
            Http http=new Http();
            HttpRequest req=new HttpRequest();
            //Set HTTPRequest Method
            req.setMethod('POST');

            //The URL is case sensitive
            req.setEndpoint(instanceUrl+'/services/apexrest/invl/v1/');
            System.debug(instanceUrl+'/services/apexrest/invl/v1/');
        
            //Set HTTPRequest header proporties
            //The content type you're sending in the form of Json
            req.setHeader('Content-Type','application/json');
            //Set oauth token at request header
            req.setHeader('Authorization','OAuth ' + accessToken);
            
           
            //Set the body after serializing object as a JSON string
            req.setBody(payLoad);
            //Make a request to external server with the prepared request by calling HTTP.send()
            HttpResponse res=http.send(req);
                
            System.debug('response:'+res.toString());
            System.debug('Status:'+res.getStatus());
            System.debug('Status code:'+res.getStatusCode());
            System.debug('resone body:'+res.getBody());
            
            //Callout made successfully the state will be 200
            if(res.getStatusCode()==200){
                //Deserialize the response body (JSON string) to Apex List class
                List<INVLResponse> responseList = (List<INVLResponse>)JSON.deserialize(res.getBody(), List<INVLResponse>.class);

                //Update INVL accordingly
                List<Invoice_Line_Item__c> updateInvlList = new List<Invoice_Line_Item__c>();
                for(INVLResponse invlRes : responseList){
                    updateInvlList.add(new Invoice_Line_Item__c(INVL_External_Id__c = invlRes.externalId, Callout_Message__c = invlRes.message));
                }
                //Update based on External Id field
                upsert updateInvlList Invoice_Line_Item__c.INVL_External_Id__c;
            }
          }catch(Exception e){
                System.debug('Exception:'+e);
          }  
    }

    //Take list of Invoice Line Item records and deserialize them as JSON string
    public static String preparePayload(List<Invoice_Line_Item__c> invlList){
        //Prepare the request body to make the callout to server
        InvoiceLineItemPayload payLoad = new InvoiceLineItemPayload();
        //Iterate over INVL records and prepare the payload
        for(Invoice_Line_Item__c invl : invlList){
            InvoiceLineItemPayload.InvoiceLineItem invlData = new InvoiceLineItemPayload.InvoiceLineItem();
            invlData.externalId =invl.INVL_External_Id__c;
            invlData.name =invl.Name;
            invlData.status =invl.Status__c;
            invlData.price =invl.Price__c;
            payLoad.incomingInvlRecords.add(invlData);
        }
        return JSON.serialize(payLoad);
    }
    
    //Class to handle the Callout response
    public class INVLResponse{
        public String externalId;
        public String message;
    }
}