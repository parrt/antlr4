// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  reg sampling_event_prev;
  reg r_reset_n;




    //Do nothing
  wire valid_sampling_event;
  wire valid_test_expr;
  wire valid_sampling_event_prev;
  assign valid_sampling_event = ~(sampling_event^sampling_event);
  assign valid_test_expr = ~(test_expr^test_expr);
  assign valid_sampling_event_prev = ~(sampling_event_prev ^
                                       sampling_event_prev);



