public with sharing class SlackMessageBuilder {

    private SlackMessageBlock.Header buildHeader(String text){
        SlackMessageBlock.Header headerSection = new SlackMessageBlock.Header();
        headerSection.type = 'section';
        headerSection.text = buildTextSection(text,'mrkdwn');
        return headerSection;
    }

    private SlackMessageBlock.Section1 buildSection1(string text) {
        SlackMessageBlock.Section1 section1 = new SlackMessageBlock.Section1();
        section1.type = 'section';
        section1.text = buildTextSection(text, 'mrkdwn');
        return section1;
    } 

    private SlackMessageBlock.Section2 buildSection2(string text) {
        SlackMessageBlock.Section2 section2 = new SlackMessageBlock.Section2();
        section2.type = 'section';
        section2.text = buildTextSection(text, 'mrkdwn');
        return section2;
    } 

    private SlackMessageBlock.Context1 buildContext1(string imageURL, string text){
        SlackMessageBlock.Context1 context1 = new SlackMessageBlock.Context1();
        context1.type = 'context';

        Map<String,Object> element1 = new Map<String,Object>();
        element1.put('type', 'image');
        element1.put('image_url', imageURL);
        element1.put('alt_text', 'alt text');

        Map<String,Object> element2 = new Map<String,Object>();
        element2.put('type', 'mrkdwn');
        element2.put('text', text);

        List<Object> elements = new List<Object>();
        elements.add(element1);
        elements.add(element2);

        context1.elements = elements;
        return context1;
    }

    private SlackMessageBlock.Context2 buildContext2(string text){

        SlackMessageBlock.Context2 context2 = new SlackMessageBlock.Context2();
        context2.type = 'context';

        Map<String,Object> element1 = new Map<String,Object>();
        element1.put('type', 'mrkdwn');
        element1.put('text', text);

        List<Object> elements = new List<Object>();
        elements.add(element1);

        context2.elements = elements;
        return context2;

    }

    private SlackMessageBlock.Text buildTextSection(string text, string type) {
        SlackMessageBlock.Text textSection = new SlackMessageBlock.Text();
        textSection.type = type;
        textSection.text = text;
        return textSection;
    }

    private SlackMessageBlock.Divider buildDivider() {
        SlackMessageBlock.Divider divider = new SlackMessageBlock.Divider();
        divider.type = 'divider';
        return divider;
    } 
    
    public List<Object> buildSlackBlock(string header, string section1Text, string Section2Text, string contextText1, string contextText2, string imageURL) {
        List<Object> blocks = new List<Object>();
        blocks.add(buildHeader(header));
        blocks.add(buildSection1(section1Text));
        blocks.add(buildSection2(Section2Text));
        blocks.add(buildContext1(imageURL, contextText1));
        blocks.add(buildContext2(contextText2));
        blocks.add(buildDivider());
        return blocks;
    }
}