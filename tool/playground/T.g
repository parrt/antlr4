grammar T;
s : (ID | ID ID?) ID ;
//s2 : ID INT | ID INT | ID INT INT;
ID : 'a'..'z'+ ;
INT : '0'..'9'+;
WS : (' '|'\n') {skip();} ;
