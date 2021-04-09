public with sharing class SlackMessageBlock {

    public class Header {
		public String type;	//section
		public Text text;
	}

	public class Section1 {
		public String type;	//section
		public Text text;
	}

    public class Section2 {
		public String type;	//section
		public Text text;
	}

    public class Context1 {
		public String type;	//section
		public List<Object> elements;
	}

	public class Context2 {
		public String type;	//section
		public List<Object> elements;
	}

    public class Divider {
        public String type; // divider
    }

    public class Text {
		public String type;	//mrkdwn
		public String text;	//*Video Title*
	}
}