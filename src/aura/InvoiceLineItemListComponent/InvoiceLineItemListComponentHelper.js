({
    getINVLData : function(cmp) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        var action = cmp.get("c.getInvoiceLineItems");
        //Fetch the passed Invoice Id and set it as parameter to server call
        var selectedInvoiceId = cmp.get("v.invoiceId");
        console.log('InvoiceLineItemListComponent selectedInvoiceId: '+selectedInvoiceId);
        action.setParams({ invoiceId : selectedInvoiceId });
 
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                var responseData = response.getReturnValue();
                console.log("InvoiceLineItemListComponent - From server: " + JSON.stringify(responseData));
                
                //Set the invoiceLineItems attriutes with the response Invoice Line Item records from server
                cmp.set("v.invoiceLineItems",responseData);
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    }
})