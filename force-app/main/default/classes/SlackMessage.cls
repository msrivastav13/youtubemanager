public with sharing class SlackMessage {
    
    public string channel;
    public List<Object> blocks = new List<Object>();

    public SlackMessage(string channel, List<Object> blocks) {
        this.channel = channel;
        this.blocks = blocks;
    }
}