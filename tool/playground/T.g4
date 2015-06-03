grammar T;

s : ID  # foo
  | INT # bar
  ;

q : ID
  | INT{;}
  ;

s2 : e EOF ;

e : e '*' e # mul
  | e '+' e # add
  | INT     # ival
  | ID      # idval
  ;

f : f '*' f # fmult
  | INT     # fintprimary
  | f '+' f # fplus
  | ID      # fidprimary
  ;

g : g '*' g
  | g '+' g
  | INT
  | ID
  ;

h : h '*' h
  | INT
  | h '+' h
  | ID
  ;


ID : [a-z]+ ;
INT : [0-9]+ ;
WS : [ \r\t\n]+ ;
