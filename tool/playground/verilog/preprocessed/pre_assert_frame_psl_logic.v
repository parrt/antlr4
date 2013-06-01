// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  wire ignore_new_start   = (action_on_new_start == `OVL_IGNORE_NEW_START);
  wire reset_on_new_start = (action_on_new_start == `OVL_RESET_ON_NEW_START);
  wire error_on_new_start = (action_on_new_start == `OVL_ERROR_ON_NEW_START);




`endmodule //Required to pair up with already used "`module" in file assert_frame.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_frame_assert (clk, reset_n, start_event, test_expr, win,
                            ignore_new_start, reset_on_new_start, error_on_new_start,
                            xzcheck_enable);
       parameter min_cks = 1;
       parameter max_cks = 2;
       input clk, reset_n, start_event, test_expr, win,
             ignore_new_start, reset_on_new_start, error_on_new_start,
             xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_frame_assume (clk, reset_n, start_event, test_expr, win,
                            ignore_new_start, reset_on_new_start, error_on_new_start,
                            xzcheck_enable);
       parameter min_cks = 1;
       parameter max_cks = 2;
       input clk, reset_n, start_event, test_expr, win,
             ignore_new_start, reset_on_new_start, error_on_new_start,
             xzcheck_enable;
endmodule


//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_frame_cover (clk, reset_n, start_event);
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n, start_event;
endmodule
