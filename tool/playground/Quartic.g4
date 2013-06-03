grammar Quartic;

s : 'x' s 'y'
  | 'x' s
  | 'x'
  ;

WS : [ \r\t\n]+ -> skip ;