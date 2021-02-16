({
    //here in JS, v represent view and c represent server controller
    doInit : function(cmp, event, helper) {
        // Set the column names when component loads
        cmp.set('v.columns', [
            {label: 'Invoice Line Item Name', fieldName: 'Name', type: 'text'},
            {label: 'Price', fieldName: 'Price__c', type: 'currency', typeAttributes: { currencyCode: 'USD', maximumSignificantDigits: 5}},
            {label: 'Status', fieldName: 'Status__c', type: 'text'}
        ]);
        //Get the Invoice and Invoice Line Items for Server
        helper.doInit(cmp);
    }
})