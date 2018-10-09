public class ContactListController {
        @AuraEnabled
    public static List<Contact> getContacts(Id recordId) {
        return [Select Id, FirstName, LastName, Email, Phone From Contact Where AccountId = :recordId];
    }  
    @AuraEnabled
    public static List<Contact> findByName(String searchKey, List<Contact> contList, Id recordId) {
        Set<Id> recordIds = new Map<Id, Contact>(getContacts(recordId)).keySet();
        system.debug('CONTACT LIST' + contList);
        String name = '%' + searchKey + '%';
        return [Select Id, FirstName, LastName, Email, Phone from Contact WHERE (FirstName LIKE :name OR LastName LIKE :name OR Email LIKE :name OR Phone LIKE :name) AND Id IN:recordIds LIMIT 50];
    }
}