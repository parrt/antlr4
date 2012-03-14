grammar T;
s : a ';' a;
a :          ID
  |          ID
  | {false}? ID
  ;
ID : 'a'..'z'+ ;
INT : '0'..'9'+;
WS : (' '|'\n') {skip();} ;
