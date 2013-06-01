// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  parameter CHANGE_START = 1'b0;
  parameter CHANGE_CHECK = 1'b1;

  reg r_change;
  reg [width-1:0] r_test_expr;
  reg r_state;
  integer i;




    //Do nothing
  wire valid_start_event;
  wire valid_test_expr;
  assign valid_start_event = ~(start_event^start_event);
  assign valid_test_expr = ~((^test_expr)^(^test_expr));





  initial begin
    r_state=CHANGE_START;
    r_change=1'b0;
  end




