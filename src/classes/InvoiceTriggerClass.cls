public with sharing class InvoiceTriggerClass {
    static Boolean isBeforeExecuted = false;
    static Boolean isAfterExecuted = false;
    public static Boolean runOnceBefore(){
        //Second time is isBeforeExecuted -> true, return false
        if(isBeforeExecuted){
            return false;
        }else{//First time is isBeforeExecuted -> false, return true
            isBeforeExecuted = true;
            return true;
        }
    }
    public static Boolean runOnceAfter(){
        //Second time is isAfterExecuted -> true, return false
        if(isAfterExecuted){
            return false;
        }else{//First time is isAfterExecuted -> false, return true
            isAfterExecuted = true;
            return true;
        }
    }

    static List<String> nameList = new List<String>();
    public static void checkException(){
        try{
            //nameList.add(null);
            String name = nameList.get(0);
            String surName = name.substringAfter(' ');
        }catch(ListException e){
            System.debug('Handle Specific Exception');
            System.debug('Cause:'+e.getCause());
            System.debug('Line Number:'+e.getLineNumber());
            System.debug('Message:'+e.getMessage());
            System.debug('Stach Trace String:'+e.getStackTraceString());
            System.debug('Type:'+e.getTypeName());
        }
        catch(Exception e){
            System.debug('Handle Generic Exception');
            System.debug('Cause:'+e.getCause());
            System.debug('Line Number:'+e.getLineNumber());
            System.debug('Message:'+e.getMessage());
            System.debug('Stach Trace String:'+e.getStackTraceString());
            System.debug('Type:'+e.getTypeName());
        }
        finally{
            System.debug('Final Statement of Try Block');
        }
    }
    //---------------throw Custom Exception ---------------------------
    public class CustomException extends Exception {}

    public static void testCustomException() {
        try {
            Integer i=0;
            // Your code here
            if (i < 5){
                throw new CustomException('This is bad');
            }
        }catch (CustomException e) {  
            // This catches the OtherException
            System.debug(e.getMessage());
        }  
    }

}