grammar T;
s : r=e ;
e : e '(' INT ')' # F
  | INT 	  # anInt
  ;     
MULT: '*' ;
ADD : '+' ;
INT : [0-9]+ ;
WS : [ \t\n]+ -> skip ;
