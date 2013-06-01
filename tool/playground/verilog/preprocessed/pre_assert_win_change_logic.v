// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  reg r_change;
  reg [width-1:0] r_test_expr;
  reg r_state;

  parameter WIN_CHANGE_START = 1'b0;
  parameter WIN_CHANGE_CHECK = 1'b1;




  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
   wire valid_start_event;
   wire valid_test_expr;
   wire valid_end_event;

   assign valid_start_event = ~(start_event^start_event);
   assign valid_test_expr = ~((^test_expr)^(^test_expr));
   assign valid_end_event = ~(end_event^end_event);
 #endif // OVL_IMPLICIT_XCHECK_OFF




  initial begin
    r_state=WIN_CHANGE_START;
    r_change=1'b0;
  end




