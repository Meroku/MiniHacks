public class SObjectUtil {
	
    public static boolean isObjectExist(String ObjectNameParam){
     for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().values() ) {
        String sobjName = String.valueOf(sObjectType);
        if (sobjName.contains(ObjectNameParam) ) {
            return true;
        }
     }
     return false;
   }
    
    public static String selectIdOfLookup(String type, String nameValue) {
        
        String result;
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(type);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        
        for (String fieldName: fieldMap.keySet()) {
            
            //It provides to get the object fields label.
            String fieldLabel = fieldMap.get(fieldName).getDescribe().getLabel();
            
            //It provides to get the object fields data type.
            Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
            
            //It provides to get field API name(field == fieldName) 
            String field = fieldMap.get(fieldName).getDescribe().getName();            
            
            List<sObject> records = Database.query('SELECT Id, :fieldName FROM ' + type);
            for(sObject record : records) {
                if(record.get(fieldName).toString() == nameValue) {
                    result = record.Id;
                }
            }
            
            if(fielddataType != Schema.DisplayType.TextArea)
            {}     //do something
            
            if(fielddataType != Schema.DisplayType.String)
            {} //do something
            
        }    
        return result; 
    }
}