/*
 [The "BSD licence"]
 Copyright (c) 2007-2008 Terence Parr
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. The name of the author may not be used to endorse or promote products
    derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
grammar JavaRats;

//
// JavaSevenCore.rats
//

tryCatchFinallyStatement
    :   'try' block (catchClause* 'finally' block | catchClause+)
    |   'try' resourceSpecification block catchClause* ('finally' block)?
    ;

resourceSpecification
    :   '(' resource (';' resource)* ';'? ')'
    ;

resource
    :   variableModifiers type resourceDeclarators //@fieldDeclaration
    ;

resourceDeclarators
    :   resourceDeclarator //@declarators
    ;

resourceDeclarator
    :   name '=' expression //@declarator
    ;

catchClause
    :   'catch' '(' catchParameter ')' block
    ;

catchParameter
    :   variableModifiers type ('|' type)* Identifier //@formalParameter
    ;

//
// JavaFiveCore.rats
//

packageDeclaration
    :   annotations? 'package' qualifiedIdentifier ';'
    ;

importDeclaration
    :   'import' 'static'? qualifiedIdentifier dotStarTail? ';'
    ;

modifier
    :   annotation
    |   'public'
    |   'protected'
    |   'private'
    |   'static'
    |   'abstract'
    |   'final'
    |   'native'
    |   'synchronized'
    |   'transient'
    |   'volatile'
    |   'strictfp'
    ;

formalParameter
    :   variableModifiers type '...'? Identifier dimensions?
    ;

variableModifiers
    :   variableModifier* //@modifiers
    ;

variableModifier
    :   finalModifier
    |   annotation
    ;

annotations
    :   annotation+
    ;

annotation
    :   '@' typeName annotationValue
    ;

annotationValue
    :   '(' elementValuePairs? ')'
    |   '(' elementValue ')'
    |   /*empty*/
    ;

elementValuePairs
    :   elementValuePair (',' elementValuePair)*
    ;

elementValuePair
    :   name '=' elementValue
    ;

elementValue
    :   expression
    |   annotation
    |   elementArrayInitializer
    ;

elementArrayInitializer
    :   '{' elementValue (',' elementValue)* ','? '}' //@arrayInitializer
    |   '{' ','? '}' //@arrayInitializer
    ;

declaration
    :   fieldDeclaration
    |   methodDeclaration
    |   constructorDeclaration
    |   classDeclaration
    |   interfaceDeclaration
    |   annotationDeclaration
    |   enumDeclaration
    |   blockDeclaration
    |   emptyDeclaration
    ;

classDeclaration
    :   modifiers 'class' name typeParameters? extension? implementation? classBody
    ;

interfaceDeclaration
    :   modifiers 'interface' name typeParameters? extension? classBody
    ;

methodDeclaration
    :   modifiers typeParameters? resultType name formalParameters dimensions? throwsClause? (block | ';')
    ;

constructorDeclaration
    :   modifiers typeParameters? name formalParameters throwsClause? block
    ;

annotationDeclaration
    :   modifiers '@' 'interface' name annotationBody
    ;

annotationBody
    :   '{' annotationElement* '}' //@classBody
    ;

annotationElement
    :   annotationMethod
    |   fieldDeclaration
    |   classDeclaration
    |   interfaceDeclaration
    |   enumDeclaration
    |   annotationDeclaration
    ;

annotationMethod
    :   modifiers type name '(' ')' defaultValue? ';'
    ;

defaultValue
    :   'default' elementValue
    ;

enumDeclaration
    :   modifiers 'enum' name implementation? '{' enumConstants? ','? enumMembers? '}'
    ;

enumConstants
    :   enumConstant (',' enumConstant)*
    ;

enumConstant
    :   annotations? name arguments? classBody?
    ;

enumMembers
    :   ';' declaration*
    ;

forControl
    :   enhancedForControl
    |   basicForControl
    ;

enhancedForControl
    :   variableModifiers type name ':' expression
    ;

postfixExpression
    :   postfixExpression '.' typeArguments? name arguments //@callExpression
    |   postfixExpression '.' 'super' arguments //@callExpression
    |   postfixExpression '.' 'super' //@superExpression
    |   postfixExpression '.' name //@selectionExpression
    |   postfixExpression '[' expression ']' //@subscriptExpression
    |   postfixExpression '++'
    |   postfixExpression '--'
    |   postfixExpression '.' 'new' typeArguments? createdName arguments classBody? //@newClassExpression
    |   primaryExpression
    ;

callExpression
    :   typeArguments? name arguments
    ;

newClassExpression
    :   'new' typeArguments? createdName arguments classBody?
    ;

createdName
    :   primitiveType
    |   Identifier typeArgumentsOrDiamond? ('.' Identifier typeArgumentsOrDiamond?)*
    ;

typeArgumentsOrDiamond
    :   typeArguments
    |   '<' '>'
    ;

//
// JavaCore.rats
//

compilationUnit
    :   packageDeclaration?
        importDeclaration*
        declaration*
        '\u001a'?
        EOF
    ;

dotStarTail
    :   '.' '*'
    ;

name
    :   Identifier
    ;

modifiers
    :   modifierList
    ;

modifierList
    :   modifier*
    ;

finalModifier
    :   'final' //@modifier
    ;

formalParameters
    :   '(' formalParameter (',' formalParameter)* ')'
    |   '(' ')'
    ;

declarator
    :   name dimensions? ('=' variableInitializer)?
    ;

declarators
    :   declarator (',' declarator)*
    ;

classBody
    :   '{' declaration* '}'
    ;

fieldDeclaration
    :   modifiers type declarators ';'
    ;

blockDeclaration
    :   'static'? block
    ;

emptyDeclaration
    :   ';'
    ;

throwsClause
    :   'throws' qualifiedIdentifier (',' qualifiedIdentifier)*
    ;

extension
    :   'extends' type (',' type)*
    ;

implementation
    :   'implements' type (',' type)*
    ;

block
    :   '{' declarationOrStatement* '}'
    ;

declarationOrStatement
    :   inBlockDeclaration
    |   statement
    ;

inBlockDeclaration
    :   variableDeclaration
    |   classDeclaration
    |   interfaceDeclaration
    ;

variableDeclaration
    :   variableModifiers type declarators ';' //@fieldDeclaration
    ;

statement
    :   block
    |   conditionalStatement
    |   forStatement
    |   whileStatement
    |   doWhileStatement
    |   tryCatchFinallyStatement
    |   switchStatement
    |   synchronizedStatement
    |   returnStatement
    |   throwStatement
    |   breakStatement
    |   continueStatement
    |   labeledStatement
    |   expressionStatement
    |   assertStatement
    |   emptyStatement
    ;

conditionalStatement
    :   'if' parExpression statement ('else' statement)?
    //|   'if' parExpression statement
    ;

forStatement
    :   'for' '(' forControl ')' statement
    ;

basicForControl
    :   variableModifiers type declarators ';' expression? ';' expressionList?
    |   expressionList? ';' expression? ';' expressionList?
    ;

whileStatement
    :   'while' parExpression statement
    ;

doWhileStatement
    :   'do' statement 'while' parExpression ';'
    ;

parExpression
    :   '(' expression ')'
    ;

switchStatement
    :   'switch' parExpression '{' switchClause* '}'
    ;

switchClause
    :   caseClause
    |   defaultClause
    ;

caseClause
    :   'case' expression ':' declarationOrStatement*
    ;

defaultClause
    :   'default' ':' declarationOrStatement*
    ;

synchronizedStatement
    :   'synchronized' parExpression block
    ;

returnStatement
    :   'return' expression? ';'
    ;

throwStatement
    :   'throw' expression ';'
    ;

breakStatement
    :   'break' Identifier? ';'
    ;

continueStatement
    :   'continue' Identifier? ';'
    ;

labeledStatement
    :   Identifier ':' statement
    ;

expressionStatement
    :   expression ';'
    ;

assertStatement
    :   'assert' expression (':' expression)? ';'
    ;

emptyStatement
    :   ';'
    ;

expressionList
    :   expression (',' expression)*
    ;

expression
    :   conditionalExpression (assignmentOperator expression)?
    //|   conditionalExpression
    ;

assignmentOperator
    :   '='
    |   '+='
    |   '-='
    |   '*='
    |   '/='
    |   '&='
    |   '|='
    |   '^='
    |   '%='
    |   '<<='
    |   '>>='
    |   '>>>='
    ;

conditionalExpression
    :   logicalOrExpression ('?' expression ':' conditionalExpression)?
    //|   logicalOrExpression
    ;

logicalOrExpression
    :   logicalOrExpression '||' logicalAndExpression
    |   logicalAndExpression
    ;

logicalAndExpression
    :   logicalAndExpression '&&' bitwiseOrExpression
    |   bitwiseOrExpression
    ;

bitwiseOrExpression
    :   bitwiseOrExpression '|' bitwiseXorExpression
    |   bitwiseXorExpression
    ;

bitwiseXorExpression
    :   bitwiseXorExpression '^' bitwiseAndExpression
    |   bitwiseAndExpression
    ;

bitwiseAndExpression
    :   bitwiseAndExpression '&' equalityExpression
    |   equalityExpression
    ;

equalityExpression
    :   equalityExpression equalityOperator instanceOfExpression
    |   instanceOfExpression
    ;

equalityOperator
    :   '=='
    |   '!='
    ;

instanceOfExpression
    :   relationalExpression ('instanceof' type)?
    //|   relationalExpression
    ;

relationalExpression
    :   relationalExpression relationalOperator shiftExpression
    |   shiftExpression
    ;

relationalOperator
    :   '<'
    |   '>'
    |   '<='
    |   '>='
    ;

shiftExpression
    :   shiftExpression shiftOperator additiveExpression
    |   additiveExpression
    ;

shiftOperator
    :   '<' '<'
    |   '>' '>'
    |   '>' '>' '>'
    ;

additiveExpression
    :   additiveExpression additiveOperator multiplicativeExpression
    |   multiplicativeExpression
    ;

additiveOperator
    :   '+'
    |   '-'
    ;

multiplicativeExpression
    :   multiplicativeExpression multiplicativeOperator unaryExpression
    |   unaryExpression
    ;

multiplicativeOperator
    :   '*'
    |   '/'
    |   '%'
    ;

unaryExpression
    :   '+' unaryExpression
    |   '-' unaryExpression
    |   '++' unaryExpression
    |   '--' unaryExpression
    |   unaryExpressionNotPlusMinus
    ;

unaryExpressionNotPlusMinus
    :   bitwiseNegationExpression
    |   logicalNegationExpression
    |   basicCastExpression
    |   castExpression
    |   postfixExpression
    ;

bitwiseNegationExpression
    :   '~' unaryExpression
    ;

logicalNegationExpression
    :   '!' unaryExpression
    ;

basicCastExpression
    :   '(' primitiveType dimensions? ')' unaryExpression
    ;

castExpression
    :   '(' type ')' unaryExpressionNotPlusMinus
    ;

primaryExpression
    :   literal
    |   callExpression
    |   classLiteralExpression
    |   thisCallExpression
    |   thisExpression
    |   superCallExpression
    |   superExpression
    |   primaryIdentifier
    |   newClassExpression
    |   newArrayExpression
    |   '(' expression ')'
    ;

classLiteralExpression
    :   resultType '.' 'class'
    ;

thisCallExpression
    :   'this' arguments //@callExpression
    ;

thisExpression
    :   (qualifiedIdentifier '.')? 'this'
    ;

superCallExpression
    :   'super' arguments //@callExpression
    ;

superExpression
    :   'super'
    ;

primaryIdentifier
    :   Identifier
    ;

newArrayExpression
    :   'new' createdName concreteDimensions dimensions?
    |   'new' createdName dimensions? arrayInitializer
    ;

concreteDimensions
    :   concreteDimension+
    ;

concreteDimension
    :   '[' expression ']'
    ;

arrayInitializer
    :   '{' variableInitializer (',' variableInitializer)* ','? '}'
    |   '{' ','? '}'
    ;

variableInitializer
    :   arrayInitializer
    |   expression
    ;

arguments
    :   '(' expression (',' expression)* ')'
    |   '(' ')'
    ;

//
// JavaFiveType.rats
//

typeParameters
    :   '<' typeParameter (',' typeParameter)* '>'
    ;

typeParameter
    :   Identifier ('extends' bound)?
    ;

bound
    :   type ('&' type)*
    ;

typeArguments
    :   '<' typeArgument (',' typeArgument)* '>'
    ;

typeArgument
    :   type
    |   wildcard
    ;

wildcard
    :   '?' wildcardBound?
    ;

wildcardBound
    :   'extends' type
    |   'super' type
    ;

classType
    :   instantiatedType
    ;

instantiatedType
    :   typeInstantiation ('.' typeInstantiation)*
    ;

typeInstantiation
    :   Identifier typeArguments?
    ;

//
// JavaType.rats
//

resultType
    :   voidType
    |   type
    ;

voidType
    :   'void'
    ;

type
    :   typeName dimensions?
    ;

typeName
    :   primitiveType
    |   classType
    ;

primitiveType
    :   'byte'
    |   'short'
    |   'char'
    |   'int'
    |   'long'
    |   'float'
    |   'double'
    |   'boolean'
    ;

dimensions
    :   ('[' ']')+
    ;

//
// JavaIdentifier.rats
//

qualifiedIdentifier
    :   Identifier ('.' Identifier)*
    ;

//
// JavaSevenConstant.rats
//

integerLiteral
    :   HexLiteral
    |   DecimalLiteral
    |   OctalLiteral
    |   BinaryLiteral
    ;

//
// JavaConstant.rats
//

literal
    :   floatingPointLiteral
    |   integerLiteral
    |   characterLiteral
    |   stringLiteral
    |   booleanLiteral
    |   nullLiteral
    ;

floatingPointLiteral
    :   FloatingPointString
    ;

characterLiteral
    :   CharacterConstant
    ;

stringLiteral
    :   StringConstant
    ;

booleanLiteral
    :   'true'
    |   'false'
    ;

nullLiteral
    :   'null'
    ;

// LEXER

// ----- Integer literals

HexLiteral : HexNumeral IntegerTypeSuffix? ;

OctalLiteral : OctalNumeral IntegerTypeSuffix? ;

DecimalLiteral : DecimalNumeral IntegerTypeSuffix? ;

BinaryLiteral : BinaryNumeral IntegerTypeSuffix? ;

fragment DecimalNumeral :   '0' | NonZeroDigit '_'+ Digits | NonZeroDigit Digits? ;
fragment NonZeroDigit : [1-9] ;
fragment Digits : Digit DigitUnderscore* Digit | Digit ;
fragment Digit : [0-9] ;
fragment DigitUnderscore : [0-9_] ;

fragment HexNumeral : '0' [xX] HexDigits ;
fragment HexDigits : HexDigit HexDigitUnderscore* HexDigit | HexDigit ;
fragment HexDigit : [0-9a-fA-F] ;
fragment HexDigitUnderscore : [0-9a-fA-F_] ;

fragment OctalNumeral : '0' OctalDigits | '0' '_'+ OctalDigits ;
fragment OctalDigits : OctalDigit OctalDigitUnderscore* OctalDigit | OctalDigit ;
fragment OctalDigit : [0-7] ;
fragment OctalDigitUnderscore : [0-7_] ;

fragment BinaryNumeral : '0' [bB] BinaryDigits ;
fragment BinaryDigits : BinaryDigit BinaryDigitUnderscore* BinaryDigit | BinaryDigit ;
fragment BinaryDigit : [01] ;
fragment BinaryDigitUnderscore : [01_] ;

fragment IntegerTypeSuffix : [lL] ;

// ----- Floating point literals

FloatingPointString
    :   Digits '.' Digits? Exponent? FloatTypeSuffix?
    |   '.' Digits Exponent? FloatTypeSuffix?
    |   Digits Exponent FloatTypeSuffix?
    |   Digits Exponent? FloatTypeSuffix
	|	HexadecimalFloatingPointLiteral
    ;

fragment Exponent : [eE] [+-]? Digits ;
fragment FloatTypeSuffix : [fFdD] ;

fragment
SignedInteger
	:	Sign? Digits
	;

fragment
Sign
	:	[+-]
	;

fragment
HexadecimalFloatingPointLiteral
	:	HexSignificand BinaryExponent FloatTypeSuffix?
	;

fragment
HexSignificand
	:	HexNumeral '.'?
	|	'0' [xX] HexDigits? '.' HexDigits
	;

fragment
BinaryExponent
	:	BinaryExponentIndicator SignedInteger
	;

fragment
BinaryExponentIndicator
	:	[pP]
	;

CharacterConstant
    :   ['] (EscapeSequence | ~['\\]) [']
    ;

StringConstant
    :   ["] (EscapeSequence | ~["\\])* ["]
    ;

fragment
EscapeSequence
    :   '\\' [btnfr"'\\]
    |   UnicodeEscape
    |   OctalEscape
    ;

fragment
OctalEscape
    :   '\\' [0-3] OctalDigit OctalDigit
    |   '\\' OctalDigit OctalDigit
    |   '\\' OctalDigit
    ;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

ENUM:   'enum'
    ;
    
ASSERT
    :   'assert'
    ;
    
Identifier 
    :   Letter (Letter|JavaIDDigit)*
    ;

/**I found this char range in JavaCC's grammar, but Letter and Digit overlap.
   Still works, but...
 */
fragment
Letter
    :  '\u0024' |
       '\u0041'..'\u005a' |
       '\u005f' |
       '\u0061'..'\u007a' |
       '\u00c0'..'\u00d6' |
       '\u00d8'..'\u00f6' |
       '\u00f8'..'\u00ff' |
       '\u0100'..'\u1fff' |
       '\u3040'..'\u318f' |
       '\u3300'..'\u337f' |
       '\u3400'..'\u3d2d' |
       '\u4e00'..'\u9fff' |
       '\uf900'..'\ufaff'
    ;

fragment
JavaIDDigit
    :  '\u0030'..'\u0039' |
       '\u0660'..'\u0669' |
       '\u06f0'..'\u06f9' |
       '\u0966'..'\u096f' |
       '\u09e6'..'\u09ef' |
       '\u0a66'..'\u0a6f' |
       '\u0ae6'..'\u0aef' |
       '\u0b66'..'\u0b6f' |
       '\u0be7'..'\u0bef' |
       '\u0c66'..'\u0c6f' |
       '\u0ce6'..'\u0cef' |
       '\u0d66'..'\u0d6f' |
       '\u0e50'..'\u0e59' |
       '\u0ed0'..'\u0ed9' |
       '\u1040'..'\u1049'
   ;

WS  :  (' '|'\r'|'\t'|'\u000C'|'\n')+ -> skip
    ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    : '//' ~('\n'|'\r')* '\r'? '\n' -> skip
    ;
