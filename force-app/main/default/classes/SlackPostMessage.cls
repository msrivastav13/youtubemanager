public with sharing class SlackPostMessage {
    
    @InvocableMethod(label='Post to Video Comment to Slack')
    public static void postMessage(List<Id> commentIds) {
        String slackURL = 'callout:SlackApp/api/chat.postMessage';
        for(Id commentId: commentIds) {
            SlackMessage slackMessage = SlackUtil.constructBlockMessage(commentId);
            System.enqueueJob(new QueueableSlackComment(commentId,slackURL,JSON.serialize(slackMessage)));
        }
    }

    public class QueueableSlackComment implements System.Queueable, Database.AllowsCallouts {
         
        private final String url;
        private final String body;
        private final String commentId;
         
        public QueueableSlackComment(String commentId,String url,String body) {
            this.url = url;
            this.body = body;
            this.commentId = commentId;
        }
         
        public void execute(System.QueueableContext ctx) {
            Map<String,Object> responseMap = new Map<String,Object>();
            String response = APIClient.makeAPICall(
                this.url,
                this.body
            );
            if(response != null) {
                responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
                if((Boolean)responseMap.get('ok')) {
                    // Update the CommentId
                    VideoComment__c comment = new VideoComment__c(
                        Id = this.commentId,
                        PostedToSlack__c = true,
                        ErrorMessage__c = ''
                    );
                    update comment;
                } else {
                    VideoComment__c comment = new VideoComment__c(
                        Id = this.commentId,
                        PostedToSlack__c = false,
                        ErrorMessage__c = response
                    );
                    update comment;
                }
            }
        }
 
    }
}