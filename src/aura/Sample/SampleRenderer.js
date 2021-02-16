/*SampleRenderer.js*/
({
	render : function(component, helper) {
      var returnVal = this.superRender();
       // Write your custom code here.
       console.log('render');
       return returnVal; 
    },
    rerender : function(component, helper) {
       this.superRerender();
       // Write your custom code here. 
       console.log('rerender');
    },
    afterRender : function(component, helper) {
      this.superAfterRender();
       // Write your custom code here. 
       console.log('afterRender');
    },
    unRender : function(component, helper) {
      this.superUnrender();
       // Write your custom code here. 
       console.log('unRender');
    }
})