trigger InvoiceTrigger on Invoice__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            System.debug('Trigger --> Before Insert');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isUpdate){
            System.debug('Trigger --> Before Update');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);

            Set<Id> invalidInvoiceIdSet = new Set<Id>();//Keep unique Ids
            for(Invoice_Line_Item__c  invl : [SELECT Id, Price__c, Invoice_Master__c FROM Invoice_Line_Item__c WHERE Invoice_Master__c IN :Trigger.new AND Price__c = null]){//Get all invoice related INVL for which Price is null/empty -> List<Invoice_Line_Item__c>
            // 1 invoice -> 1 INVL -> 1 invoice Id
            // 1 invoice -> 20 INVL -> 20 invoice Id (Same)
                invalidInvoiceIdSet.add(invl.Invoice_Master__c);
            }
            for(Invoice__c invoice : Trigger.new){
                Invoice__c oldInvoice = Trigger.oldMap.get(invoice.Id);
                if(invoice.Status__c != oldInvoice.Status__c && invoice.Status__c == 'Processed' && invalidInvoiceIdSet.contains(invoice.Id)){
                    invoice.addError('Make sure all Invoice Line Items Price available.');
                }
            }
        }else if(Trigger.isDelete){
            System.debug('Trigger --> Before Delete');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isUndelete){//No before Undelete
            System.debug('Trigger --> Before Undelete');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }
    }else if(Trigger.isAfter){
        if(Trigger.isInsert){
            System.debug('Trigger --> After Insert');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isUpdate){
            System.debug('Trigger --> After Update');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isDelete){
            System.debug('Trigger --> After Delete');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isUndelete){
            System.debug('Trigger --> After Undelete');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }
    }
}