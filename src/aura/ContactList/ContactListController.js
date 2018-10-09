({
	myAction : function(component, event, helper) {
		        var action = component.get("c.getContacts");
        component.set("v.Columns", [
            {label:"First Name", fieldName:"FirstName", type:"text"},
            {label:"Last Name", fieldName:"LastName", type:"text"},
            {label:"Phone", fieldName:"Phone", type:"phone"}
        ]);
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Contacts", data.getReturnValue());
        });
        $A.enqueueAction(action);
        
	},
    redirectToSobject: function(component, event) {
      var selectedItem = event.currentTarget;
      var IdP = selectedItem.dataset.record;
      
      if ((typeof sforce != 'undefined') && sforce && (!!sforce.one))
       	sforce.one.navigateToSObject(IdP);
      else{
           location.href = '/' + IdP;
      }
   },
    searchKeyChange : function(component, event, helper){
    helper.findByName(component,event); 
}
})