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
}