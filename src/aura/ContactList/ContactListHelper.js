({
    findByName: function(component,event) {  
        var searchKey = event.getParam("searchKey");
        var contList = component.get("v.Contacts");
        var recordId = component.get("v.recordId");
        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey,
            "contList" : contList,
            "recordId" : recordId
        }); 
        action.setCallback(this, function(a) {
            component.set("v.Contacts", a.getReturnValue()); 
        });
        $A.enqueueAction(action);  
    }
})