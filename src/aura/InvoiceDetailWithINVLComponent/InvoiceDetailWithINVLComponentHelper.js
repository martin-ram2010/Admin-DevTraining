({
    doInit : function(cmp) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        var action = cmp.get("c.getInvoiceWithInvl");
        var recordId = cmp.get("v.recordId");
        console.log('recordId:'+recordId);
        //Set the parameter for server action - passing the current Invoice record Id to getInvoiceWithInvl method
        action.setParams({ invoiceId : recordId });
 
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state:'+state);
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                var responseData = response.getReturnValue();
                console.log("From server: " + JSON.stringify(responseData));
                //Set the values on attributes after getting response, so it'll be rendered on UI(component) automatically
                cmp.set("v.invoiceRecord",responseData.invoiceRec);
                cmp.set("v.invlList",responseData.invlList);
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
})