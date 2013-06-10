import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.List;

public class ExtractInheritance extends JavaBaseListener {
	JavaParser parser;
	public ExtractInheritance(JavaParser parser) { this.parser = parser; }

	/*
	normalClassDeclaration
	    :   'class' Identifier typeParameters?
	        ('extends' type)?
	        ('implements' typeList)?
	        classBody
	    ;

	 */
	@Override
	public void enterNormalClassDeclaration(JavaParser.NormalClassDeclarationContext ctx) {
		TerminalNode id = ctx.Identifier();
		String sup = null;
		if ( ctx.type()!=null ) {
			sup = ctx.type().getText();
			System.out.println("\""+id+"\" -> \""+sup+"\"");
		}
		if ( ctx.typeList()!=null ) {
			List<? extends JavaParser.TypeContext> type = ctx.typeList().type();
			for (JavaParser.TypeContext t : type) {
				System.out.println("\""+id+"\" -> \""+t.getText()+"\"");
			}
		}
	}

	/*
	normalInterfaceDeclaration
	    :   'interface' Identifier typeParameters? ('extends' typeList)? interfaceBody
	    ;

	 */

	@Override
	public void enterNormalInterfaceDeclaration(JavaParser.NormalInterfaceDeclarationContext ctx) {
		TerminalNode id = ctx.Identifier();
		System.out.println("###### interface "+id);
		String args = null;
		if ( ctx.typeList()!=null ) {
			List<? extends JavaParser.TypeContext> type = ctx.typeList().type();
			for (JavaParser.TypeContext t : type) {
				System.out.println("\""+id+"\" -> \""+t.getText()+"\"");
			}
		}
	}
}
