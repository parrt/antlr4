lexer grammar L;
STRING : '""' .*? '""' ;
/*
STRING : '"' ('""' | .)*? '"' ;
S : '"' (~'\n' | .)*? '"' ;
*/
WS : [ \r\t\n]+ ;
