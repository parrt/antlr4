// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  integer cnt;



  initial begin
    cnt=0;
  end






    //Do nothing
  wire valid_push;
  wire valid_pop;

  assign valid_push = ~((^push) ^ (^push));
  assign valid_pop = ~((^pop) ^ (^pop));


