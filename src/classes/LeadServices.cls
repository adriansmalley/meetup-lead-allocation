public class LeadServices{
    public static List<Lead> getOpenLeads() {

      return [
        SELECT Id, Name, Company, Skills_Tags__c, OwnerId
        FROM Lead
        Where Ownerid='00Gi0000001iJ2n'
      ];
    }

    public static List<Lead> getAllLeads() {
      return [
        SELECT Id, Name, OwnerId, Company, Skills_Tags__c
        FROM Lead
      ];
    }

    public static Map<Id, List<Lead>> getLeadsPerUser() {
      List<Lead> closedLeads = getAllLeads();

      List<User> allUsers = [
        SELECT Id
        FROM User
      ];

      Map<Id, List<Lead>> leadsPerUser = new Map<Id, List<Lead>>();

      for (User u: allUsers) {
        leadsPerUser.put(u.Id, new List<Lead>());
      }

      for (Lead l: closedLeads) {
        if (leadsPerUser.containsKey(l.OwnerId)) {
          leadsPerUser.get(l.OwnerId).add(l);
        } else {
          leadsPerUser.put(l.OwnerId, new List<Lead>{l});
        }
      }
      return leadsPerUser;
    }

    public static Map<Id, Integer> getNumberOfLeadsPerUser() {
      List<Lead> closedLeads = getAllLeads();

      Map<Id, Integer> leadsPerUser = new Map<Id, Integer>();
      for (Lead l: closedLeads) {
        if (leadsPerUser.containsKey(l.OwnerId)) {
          leadsPerUser.put(l.OwnerId, leadsPerUser.get(l.OwnerId) + 1);
        } else {
          leadsPerUser.put(l.OwnerId, 0);
        }
      }
      return leadsPerUser;
    }

    public static Integer getMaxNumberOfLeads() {
      Map<Id, Integer> numberOfLeadsPerUser = getNumberOfLeadsPerUser();
      Integer maxLeads = 0;
      for (Id u: numberOfLeadsPerUser.keySet()) {
        if (numberOfLeadsPerUser.get(u) > maxLeads) {
          maxLeads = numberOfLeadsPerUser.get(u);
        }
      }
      return maxLeads;
    }

    public static void notifyUserOfLead(User u, Lead l) {
      HttpRequest req = new HttpRequest();
      req.setEndpoint('http://still-fjord-5374.herokuapp.com/send');
      req.setMethod('POST');
      req.setBody('subject="A new Lead for you!"'
        + 'message="' + l.Name + '"'
        + 'receipient="kettelhoit@gmail.com"'
        + 'receipient_name="Frederic Kettelhoit"');

      Http http = new Http();
      HTTPResponse res = http.send(req);
      System.debug(res.getBody());
    }
}