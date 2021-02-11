trigger InvoiceTrigger on Invoice__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            System.debug('Trigger --> Before Insert');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);

            Group invoiceQueue = [SELECT Id, Name, DeveloperName, Type FROM Group WHERE DeveloperName='Invoice_Processor_Queue' AND Type ='Queue' LIMIT 1];
            for(Invoice__c invoice : Trigger.new){
                //Update the default values ->  Invoice Owner to default Invoice_Processor_Queue Queue
                //Staus as Ready for Processing
                if(invoice.Status__c == 'New'){
                    invoice.OwnerId = invoiceQueue.Id;
                    invoice.Status__c = 'Ready for Processing';
                }
            }
        }else if(Trigger.isUpdate){
            // if(InvoiceTriggerClass.runOnceBefore() == false){
            //      return;
            // }
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
                // invoice.Street__c ='test Street';
                // invoice.Status__c = 'test';
                //invoice.Status__c = 'Processed';//You can do this, because Trigger.new is editable in the Before event, No explicit Update statement requires : update invoice; is not required.
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
        if(Trigger.isInsert){//The current Invoice Record is not available to User, so no Invoice Line Item can be created on current Invoice by the End User.
            System.debug('Trigger --> After Insert');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);
        }else if(Trigger.isUpdate){//The current Invoice Record is available to User, so Invoice Line Item could be created on current Invoice by the End User.
            // if(InvoiceTriggerClass.runOnceAfter() == false){
            //      return;
            // }
            System.debug('Trigger --> After Update');
            System.debug('old:'+Trigger.old);
            System.debug('oldMap:'+Trigger.oldMap);
            System.debug('new:'+Trigger.new);
            System.debug('newMap:'+Trigger.newMap);

            List<Id> invoiceIdList = new List<Id>();
            //Iterating over newly updated Invoice reocrds and check the Status got updated to Processed, if so then collect those invoice Ids.
            for(Invoice__c invoice : Trigger.new){
                //invoice.Status__c = 'Processed';//You can not do this, because Trigger.new is readable only in the After event
                Invoice__c oldInvoice = Trigger.oldMap.get(invoice.Id);
                if(invoice.Status__c != oldInvoice.Status__c && invoice.Status__c == 'Processed'){
                    invoiceIdList.add(invoice.Id);
                }
            }
            if(!invoiceIdList.isEmpty()){
                List<Invoice_Line_Item__c> invlList = new List<Invoice_Line_Item__c>();
                for(Invoice_Line_Item__c  invl : [SELECT Id, Price__c, Invoice_Master__c, Status__c FROM Invoice_Line_Item__c WHERE Invoice_Master__c IN :invoiceIdList AND Status__c != 'Processed']){//Get all invoice related INVL for which the Status is not Processed -> List<Invoice_Line_Item__c>
                    invl.Status__c = 'Processed';
                    invl.Price__c =invl.Price__c - invl.Price__c * 0.1;
                    //update invl; //150 DML
                    invlList.add(invl);
                }
                //If invlList is not Empty then only update the list of invoice line item records
                if(!invlList.isEmpty()){
                    update invlList;
                }
            }
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