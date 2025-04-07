public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        //Set Endpoint from Named Credential
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
        req.setMethod('POST');
        req.setBody(jsonBody);
        Http http = new Http();
        
        //Make HTTP Callout
        HTTPResponse res = http.send(req);
        
        //Update to return response status code
        return res.getStatusCode();    
    }
}