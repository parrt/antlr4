grammar Quartic;

s : a EOF ;

a : 'x' a a
  | 'x' a
  | 'x'
  ;

WS : [ \r\t\n]+ -> skip ;
