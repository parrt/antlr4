// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  parameter UNCHANGE_START = 1'b0;
  parameter UNCHANGE_CHECK = 1'b1;

  reg [width-1:0] r_test_expr;
  reg r_state;
  integer i;




  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
  wire valid_start_event;
  wire valid_test_expr;
  assign valid_start_event = ~(start_event^start_event);
  assign valid_test_expr = ~((^test_expr)^(^test_expr));
 #endif // OVL_IMPLICIT_XCHECK_OFF




  initial begin
    r_state=UNCHANGE_START;
  end



