grammar T;
s : ID?? ID*? ID+? ;
t : (A|B)?? (A|B)*? (A|B)+? ;
ID : 'a'..'z'+ ;
WS : (' '|'\t'|'\n')+ {skip();} ;
