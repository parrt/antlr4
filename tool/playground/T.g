grammar T;
s : e EOF ;

/*
e[int _p]
    :   ID
        ( {3 >= $_p}? '*' e[4]
        | {2 >= $_p}? '+' e[3]
        )*
    ;
*/

e : e '*' e
  | e '+' e
  | ID
  ;
ID : [a-zA-Z]+;
WS : [ \n\t]+ -> skip;
