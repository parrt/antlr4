import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.DiagnosticErrorStrategy;

public class TestT {
	public static void main(String[] args) throws Exception {
		CharStream input = new ANTLRFileStream(args[0]);
		TLexer lex = new TLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lex);
		TParser parser = new TParser(tokens);

		parser.setErrorHandler(new DiagnosticErrorStrategy());
		parser.setBuildParseTree(true);
		parser.s();
	}
}
