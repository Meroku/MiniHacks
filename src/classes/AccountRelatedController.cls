public class AccountRelatedController {
    @AuraEnabled
    public static Id getId(String cont){
        Contact c = [select AccountId from Contact where Id = :cont];
        return c.AccountId;
    }
}