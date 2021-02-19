//Client Side SOAP callout
public with sharing class SOAPCalloutExample {
    public static final String USERNAME ='admintrainer@2021.com';
    public static final String PASSWORD ='start042021';
    public static final String SECURITY_TOKEN ='wbS1phS3b13LqhGLgPwRLDoNm';
    
    public static String getMessage(){
        //Create SOAP instance
        PartnerSoap.Soap soap = new PartnerSoap.Soap();
        //Start Login and get the session Id using LoginResult
        PartnerSoap.LoginResult loginResult=soap.login(USERNAME, PASSWORD + SECURITY_TOKEN);
        String sessionId= loginResult.sessionId;
        String serverUrl= loginResult.serverUrl;
        System.debug('sessionId:'+sessionId);
        System.debug('serverUrl:'+serverUrl);

        //Set the sesssion Id in SessionHeader and make a soap callout to custom SOAP webservice
        SOAPSampleCallout.SoapSample sampleCallout = new SOAPSampleCallout.SoapSample();
        sampleCallout.SessionHeader= new SOAPSampleCallout.SessionHeader_element();
        sampleCallout.SessionHeader.sessionId =sessionId;
        //sampleCallout.timeout_x =120;
        String message = sampleCallout.getMessage();
        System.debug('message:'+message);
        return message;
    }
}