public with sharing class UserServices {
	public static list<User> getActiveUsers(){
        return [select id, name, SmallPhotoUrl, Skills_Tags__c from user where isActive = True];
    }
}