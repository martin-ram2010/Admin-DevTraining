({
    //Invoke the below function to handle the component event and Fetch the INVL records based on received Invoice Id through the event
    handleComponentEvent : function(cmp, event) {
        //Set the selected Invoice Id value to null by default
        cmp.set("v.selectedInvoiceId", undefined);
        // The controller retrieves the data sent in the component event and uses it to get the Invoice Line Items in the handler component.
        var invoiceId = event.getParam("selectedInvoiceId");
        //If received Invoice Id is not null then set the Invoice Id value in selectedInvoiceId attribute
        if(invoiceId){
            cmp.set("v.selectedInvoiceId", invoiceId);

            //Fire Application Event InvoiceSelectApplicationEvent, so CompleteInvoiceDetailComponent can handle and load the Invoice record details
            // Get the application event by using the e.<namespace>:<event> syntax
            var appEvent = $A.get("e.c:InvoiceSelectApplicationEvent");
            // Optional: set some data for the event (also known as event shape)
            // A parameter’s name must match the name attribute
            // of one of the event’s <aura:attribute> tags
            appEvent.setParams({ "selectedInvoiceId" : invoiceId });
            appEvent.fire();
        }

        
 
    }
})