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
    
    public static List<sObject> selectIdOfLookup(String typeOfObj, String nameValue) {
        
        List<sObject> result = new List<sObject>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(typeOfObj);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        
        for (String fieldName: fieldMap.keySet()) {
            
            List<sObject> records = Database.query('SELECT ' + String.ValueOf(fieldName) + ' FROM ' + typeOfObj);
            for(sObject record : records) {
                if(record.get(fieldName).toString() == nameValue) {
                    result.add(record);
                }
            }            
        }    
        return result; 
    }
}