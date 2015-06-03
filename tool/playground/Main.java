import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;

public class Main {
	public static class MyListener extends TBaseListener {
		Parser parser;
		public MyListener(Parser parser) {
			this.parser = parser;
		}
		public void enterEveryRule(ParserRuleContext ctx) {
			System.out.println("enter   " + parser.getRuleNames()[ctx.getRuleIndex()]);
		}
		@Override
		public void visitTerminal(TerminalNode node) {
			System.out.println("consume " + node.getSymbol() + " rule " +
							   parser.getRuleNames()[parser.getContext().getRuleIndex()]);
		}
		@Override
		public void visitErrorNode(ErrorNode node) {
		}
		@Override
		public void exitEveryRule(ParserRuleContext ctx) {
			System.out.println("exit    "+parser.getRuleNames()[ctx.getRuleIndex()]);
		}
		@Override public void enterIval(TParser.IvalContext ctx) { System.out.println("enter ival"); }
		@Override public void exitIval(TParser.IvalContext ctx)  { System.out.println("exit ival"); }
		@Override public void enterIdval(TParser.IdvalContext ctx) { System.out.println("enter idval"); }
		@Override public void exitIdval(TParser.IdvalContext ctx)  { System.out.println("exit idval"); }
		@Override public void enterAdd(TParser.AddContext ctx)   { System.out.println("enter add"); }
		@Override public void exitAdd(TParser.AddContext ctx)    { System.out.println("exit add"); }
		@Override public void enterMul(TParser.MulContext ctx)   { System.out.println("enter mul"); }
		@Override public void exitMul(TParser.MulContext ctx)    { System.out.println("exit mul"); }
	}

	public static void main(String[] args) {
		TParser parser = new TParser(new CommonTokenStream(new TLexer(new ANTLRInputStream("34"))));
		parser.addParseListener(new MyListener(parser));

		parser.s2();

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
