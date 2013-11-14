public with sharing class leaddistro {
    
    public list<lead> leads {get; set;}
    public list<user> users {get; set;}
    public map<id, user> userMap {get; set;}
    
    //this should be the map of user id and actual leads he owns
    public map<id, List<lead>> userleads {get; set;}
    public leaddistro(){
           leads = leadServices.getOpenLeads(); 
           users = userServices.getActiveUsers();
           userMap = new map<id, user>(userServices.getActiveUsers());
           userLeads = leadServices.getLeadsPerUser();
    }

    @remoteAction
    public static lead updateLeadOwner(string oid, string lid){

        lead updateLead = new lead(id=lid, ownerid = oid);

        try{
            update updateLead;
        }catch(exception e){
            throw(e);
        }

        return updateLead;
    }
    
     /*   public class userDetails{
                public user activeUser{get; set;}
                
                public userDetails(final user activeUser){
                                this.activeUser = activeUser;
                                
                }
        }
        
        public class leadDetails{
                public list<Lead> openLeads{get; set;}
                
                public leadDetails(final list<lead> openLeads)
                {
                        this.openLeads = openLeads;
                        for(lead l : openLeads){
                        
                        }
                }   
        } */
}