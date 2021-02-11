public with sharing class ExceptionClass {
    //Custom Exception to throw the exception manually
    public class CustomException extends Exception {}

    //Hold all the names in a list
    static List<String> nameList = new List<String>();

    public static void checkException(){
        try{
            nameList.add('Ranjan BJ');
            String name = nameList.get(0);//nameList[0]
            String surName = name.substringAfter(' ');
            System.debug('Sur Name :'+surName);
            if(name.containsIgnoreCase('test')){
                throw new CustomException('The provided name is invalid.');
            }
        }catch(ListException e){ //Standard Exceptions thrown by Salesforce and cannot be thrown manually
            System.debug('Handle Specific Exception -> Name is not provided');
            System.debug('Cause:'+e.getCause());
            System.debug('Line Number:'+e.getLineNumber());
            System.debug('Message:'+e.getMessage());
            System.debug('Stack Trace String:'+e.getStackTraceString());
            System.debug('Type:'+e.getTypeName());
        }
        catch(Exception e){
            System.debug('Handle Generic Exception');
            System.debug('Cause:'+e.getCause());
            System.debug('Line Number:'+e.getLineNumber());
            System.debug('Message:'+e.getMessage());
            System.debug('Stack Trace String:'+e.getStackTraceString());
            System.debug('Type:'+e.getTypeName());
        }
        finally{
            System.debug('Final Statement of Try Block');
        }
    }
}