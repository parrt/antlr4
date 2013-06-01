// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.




`endmodule //Required to pair up with already used "`module" in file assert_one_hot.vlib

//Module to be replicated for assert checks
//This module is bound to the PSL vunits with assert checks
module assert_one_hot_assert (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_one_hot_assume (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_one_hot_cover (clk, reset_n, test_expr, one_hots_checked);
       parameter width = 1;
       parameter OVL_COVER_SANITY_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n;
       input [width-1:0] test_expr, one_hots_checked;
endmodule
