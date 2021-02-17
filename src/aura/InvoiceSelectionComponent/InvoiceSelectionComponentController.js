({
    doInit: function (cmp, event, helper) {
        helper.doInit(cmp);
    },
    handleChange: function (cmp, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        var selectedOptionValue = event.getParam("value");
        console.log('Selected Invoice Id:'+selectedOptionValue)
        //Fire the component event if Invoice Id is selected and not undefined
        if(selectedOptionValue){
            helper.fireComponentEvent(cmp, selectedOptionValue);
        }
    }
})