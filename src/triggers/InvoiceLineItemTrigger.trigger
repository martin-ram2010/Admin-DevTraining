trigger InvoiceLineItemTrigger on Invoice_Line_Item__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
   
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                System.debug('Trigger --> Before Insert Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
    
            }else if(Trigger.isUpdate){
                System.debug('Trigger --> Before Update Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
    
            }else if(Trigger.isDelete){
                System.debug('Trigger --> Before Delete Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
            }else if(Trigger.isUndelete){//No before Undelete
                System.debug('Trigger --> Before Undelete Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
            }
        }else if(Trigger.isAfter){
            if(Trigger.isInsert){//The current Invoice Record is not available to User, so no Invoice Line Item can be created on current Invoice by the End User.
                System.debug('Trigger --> After Insert Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
            }else if(Trigger.isUpdate){
                System.debug('Trigger --> After Update Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
    
            }else if(Trigger.isDelete){
                System.debug('Trigger --> After Delete Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
            }else if(Trigger.isUndelete){
                System.debug('Trigger --> After Undelete Invoice Line Item');
                System.debug('old:'+Trigger.old);
                System.debug('oldMap:'+Trigger.oldMap);
                System.debug('new:'+Trigger.new);
                System.debug('newMap:'+Trigger.newMap);
            }
        }
    }