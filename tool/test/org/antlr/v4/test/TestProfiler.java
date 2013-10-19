package org.antlr.v4.test;

import org.junit.Test;
import static org.junit.Assert.*;

public class TestProfiler extends BaseTest {
	@Test public void test() throws Exception {
		String grammar =
			"grammar T;\n" +
			"a : ID INT;\n" +
			"ID : 'a'..'z'+ ;\n" +
			"INT : '0'..'9'+;\n" +
			"WS : [ \\n]+ -> skip ;\n";

		String found = execParser("T.g4", grammar, "TParser", "TLexer", "a",
								  "abc 34", false, true);
		assertEquals("", found);
		assertEquals(null, stderrDuringParse);
	}

}
