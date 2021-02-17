({
    doInit : function(cmp) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        var action = cmp.get("c.getAllInvoice");
 
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                var responseData = response.getReturnValue();
                console.log("From server: " + JSON.stringify(responseData));
                var options =[];
                options.push({'label': '--None--', 'value': ''});
                responseData.forEach(invoiceRecord => {
                    options.push({'label': invoiceRecord.Name, 'value': invoiceRecord.Id});
                });
                //After options array built set the options attribute
                cmp.set("v.options", options);
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
    },
    fireComponentEvent : function(cmp, invoiceId) {
        // Get the component event by using the
        // name value from aura:registerEvent
        var cmpEvent = cmp.getEvent("invoiceSelectionEvent");
        cmpEvent.setParams({"selectedInvoiceId" : invoiceId});
        cmpEvent.fire();
    }
})