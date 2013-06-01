// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
  wire valid_start_event;
  wire valid_test_expr;
  assign valid_start_event = ~(start_event ^ start_event);
  assign valid_test_expr   = ~(test_expr   ^ test_expr);
 #endif // OVL_IMPLICIT_XCHECK_OFF




