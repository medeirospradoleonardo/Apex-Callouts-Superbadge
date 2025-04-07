@isTest
global class RewardsCalloutServiceMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody('{"status":"success"}');
        res.setStatusCode(200);
        return res;
    }
}