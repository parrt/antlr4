// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.






`endmodule //Required to pair up with already used "`module" in file assert_win_unchange.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_win_unchange_assert (clk, reset_n, start_event, end_event, test_expr, window,
                                   xzdetect_test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, start_event, end_event, window;
       input [width-1:0] test_expr;
       input xzdetect_test_expr, xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_win_unchange_assume (clk, reset_n, start_event, end_event, test_expr, window,
                                   xzdetect_test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, start_event, end_event, window;
       input [width-1:0] test_expr;
       input xzdetect_test_expr, xzcheck_enable;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_win_unchange_cover (clk, reset_n, start_event, end_event, window);
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n, start_event, end_event, window;
endmodule
