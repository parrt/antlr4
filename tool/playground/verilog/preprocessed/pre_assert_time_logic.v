// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

// local paramaters used as defines
  parameter TIME_START = 1'b0;
  parameter TIME_CHECK = 1'b1;

  reg [31:0] i;

  reg r_state;




    //Do nothing
  wire valid_start_event;
  wire valid_test_expr;
  assign valid_start_event = ~(start_event^start_event);
  assign valid_test_expr = ~((^test_expr)^(^test_expr));




  initial begin
    r_state=TIME_START;
  end



