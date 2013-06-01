// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

// local paramaters used as defines
  parameter WINDOW_START = 1'b0;
  parameter WINDOW_CHECK = 1'b1;

  reg r_state;



  initial begin
    r_state=WINDOW_START;
  end





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




