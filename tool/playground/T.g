grammar T;
s : f f EOF;
f : | x;
x : 'a' 'b';
<<<<<<< HEAD
=======
INT : '0'..'9'+;
WS : (' '|'\n') {skip();} ;
>>>>>>> 9a0aaac
