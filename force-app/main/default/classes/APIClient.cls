public inherited sharing class APIClient { 

    public static String makeAPICall(String endpoint, String body) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setHeader('Authorization', 'Bearer {!$Credential.OAuthToken}');
            request.setHeader('Content-Type', 'application/json');
            request.setTimeout(120000);
            request.setMethod('POST');
            system.debug(body);
            request.setBody(body);
            HttpResponse response = http.send(request);
            System.debug('HTTP RESPONSE BODY..' + response.getBody());
            return response.getBody();
        } catch (Exception ex) {
            system.debug('Exception in tooling API Call:' + ex.getMessage());
            return ex.getMessage();
        }
    }
}