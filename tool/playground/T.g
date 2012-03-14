grammar T;
s : e ;

/*
e[int _p]
    :   ( ID '=' e[3]
        | ID
        )
        ( {1 >= $_p}? '+' e[2]
        )*
    ;
*/

e :   ID '=' e 
  |   ID           
  |   e '+' e
  ;

ID : 'a'..'z'+ ;
INT : '0'..'9'+ ;
WS : (' '|'\n') {skip();} ;
