grammar T;
s : a* ;

a : 'var' INT ';'
  | 'var' INT '.' 
  ;
INT : [0-9]+ ;
WS : [ \t\n]+ -> skip ;
