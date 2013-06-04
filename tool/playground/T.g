grammar T;

expr 	: ID
	| 'not' expr
	| expr 'or' expr
	| expr 'and' expr
	;

ID : [a-zA-Z_] [a-zA-Z0-9_]*;
WS : [ \r\t\n]+ -> skip ;
