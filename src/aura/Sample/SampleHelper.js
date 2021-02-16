/*SampleHelper.js*/
({
	updateInvoice : function(component) {
		var invoice= component.get("v.invoiceRecord");
		var action= component.get("c.saveInvoice");
        action.setParams({"invoice" : invoice});
        if(callback){
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
	}
})