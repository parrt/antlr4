grammar Quartic;

s : a EOF ;

ignored : a 'x'* EOF ; // force SLL conflict

a : 'x' a 'y'
  | 'x' a
  | 'x'
  ;

WS : [ \r\t\n]+ -> skip ;
