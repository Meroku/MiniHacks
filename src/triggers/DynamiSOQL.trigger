trigger DynamiSOQL on Car__c (before insert) {
    Map<String, Schema.SObjectField> fieldMap = Car__c.SObjectType.getDescribe().fields.getMap(); // Select all fields 
    String manufacturer;
    
    for (Car__c car : Trigger.new) {
        
        for (String key : fieldMap.keySet()) {           // key for fileds
            
            SObjectField field = fieldMap.get(key);      // real field
            
            if (field.getDescribe().getType() == DisplayType.String && field.getDescribe().getName().endsWith('__c')) { 
                
                String lookupName = field.getDescribe().getName();
                String lookupField = lookupName.substringBefore('_') + '__c';
                
                /*If lookup exist in our object find it, if not skip*/
                if(SObjectUtil.isObjectExist(lookupField)) {
                    
                    if(car.get(lookupName) != null && car.get(lookupField) == null) {
                        String RecordName = car.get(lookupName).toString();
                        
                        
                        List<sObject> Record = SObjectUtil.selectIdOfLookup(lookupField, RecordName);
                        
                        
                        /*saving id of manufacturer__c if there are more than one model with non-unique Name*/
                        if (lookupField.equals('Manufacturer__c')) {
                            manufacturer = Record[0].Id; 
                        }
                        
                        if(lookupField.equals('Model__c') && Record.size() > 1 && manufacturer != null) {
                            List<Model__c> models = [SELECT Id FROM Model__c WHERE Manufacturer__c = :manufacturer];
                            car.put(lookupField, models[0].Id);
                            /* Else If size of records < than 2 save as other lookups*/
                        } else {
                            
                            if (Record.size()>0) {
                                car.put(lookupField, Record[0].Id);
                            }
                            else {
                                car.addError('Not found lookup name!');
                            }   
                        }
                    } else if(car.get(lookupName) == null && car.get(lookupField) != null) {
                        List<sObject> Record = Database.query('SELECT Name FROM ' + lookupField);
                        car.put(lookupName, (String)Record[0].get('Name'));
                    }        
                }
            }
        }
    }
}