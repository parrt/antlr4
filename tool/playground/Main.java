import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;

public class Main
{
    public static void main(String[] args) {
        TParser parser = new TParser(new CommonTokenStream(new TLexer(new ANTLRInputStream("b"))));
        parser.addParseListener(new MyTBaseListener());

		parser.s();

//		System.out.println("######################");
//		parser = new TParser(new CommonTokenStream(new TLexer(new ANTLRInputStream("x"))));
//		parser.addParseListener(new MyTBaseListener());
//		parser.q();
    }

	private static class MyTBaseListener extends TBaseListener {
		@Override
		public void exitEveryRule(ParserRuleContext ctx) {
			System.out.println("exitEveryRule");
		}

		@Override
		public void enterEveryRule(ParserRuleContext ctx) {
			System.out.println("enterEveryRule");
		}
	}
}
