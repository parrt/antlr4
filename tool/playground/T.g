grammar T;

s : A s B
  | A s C
  | X
  ;

A : 'a' ;
B : 'b' ;
C : 'c' ;
X : 'x' ;
WS : [ \r\t\n]+ -> skip;
