grammar T;

s : A ;

A : '"' .*? '"' ;
B : ~'x'*? 'y' ;
C : ~[a-z]*? ';' ;
D : ('a'|'b')*? 'a' ;
E : ~('a'|'b')*? 'a' ;
F : 'xx'*? 'x' ; // could match just 'x'
G : ('x'|'xx')*? 'z' ;
H : '#' ('\\n'|.)*? '\n' ;

I : 'x'+? 'xxx' ;
J : 'y'?? 'yy' ;
K : ('y'|.)?? 'yy' ;

L : K+? ;
