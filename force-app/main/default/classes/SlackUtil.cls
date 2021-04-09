public with sharing class SlackUtil {
    public static SlackMessage constructBlockMessage(Id commentId) {
        List<VideoComment__c> videoComments = [
            SELECT
                AuthorImageURL__c,
                Author_Name__c,
                CommentText__c,
                Video__r.SlackUserId__c,
                Video__r.Title__c,
                Video__r.VideoURL__c,
                CommentLikeCount__c
            FROM VideoComment__c
            WHERE Id = :commentId
        ];
        if (videoComments.size() > 0) {
            SlackMessageBuilder message = new SlackMessageBuilder();

            String headerSection = '*<{0}|{1}>*';
            headerSection = String.format(headerSection, new List<String>{videoComments[0].Video__r.VideoURL__c,videoComments[0].Video__r.Title__c});

            String section1Text = 'Hello *<@{0}>,*';
            section1Text = String.format(section1Text, new List<String>{videoComments[0].Video__r.SlackUserId__c});

            String section2Text = '*New Comment*\n ' + videoComments[0].CommentText__c;

            String context1Text =  'posted by ♦️ *{0}*';
            context1Text = String.format(context1Text, new List<String>{videoComments[0].Author_Name__c});

            String context2Text = '👍 {0}     👎 0';
            context2Text = String.format(context2Text, new List<String>{String.valueOf(videoComments[0].CommentLikeCount__c)});

            List<Object> messageBody = message.buildSlackBlock(headerSection, section1Text, Section2Text, context1Text, context2Text, videoComments[0].AuthorImageURL__c);
            return new SlackMessage(
                videoComments[0].Video__r.SlackUserId__c,
                messageBody
            );
        } else {
            return null;
        }
    }
}