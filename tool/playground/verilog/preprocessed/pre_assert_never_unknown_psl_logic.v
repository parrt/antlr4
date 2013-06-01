// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





`endmodule //Required to pair up with already used "`module" in file assert_never.vlib

//Module to be replicated for assert checks
//This module is bound to the PSL vunits with assert checks
module assert_never_unknown_assert (clk, reset_n, qualifier, test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, qualifier, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_never_unknown_assume (clk, reset_n, qualifier, test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, qualifier, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for cover checks
//This module is bound to a PSL vunits with cover checks
module assert_never_unknown_cover (clk, reset_n, qualifier, test_expr);
       parameter width = 8;
       parameter OVL_COVER_SANITY_ON = 1;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n, qualifier;
       input [width-1:0] test_expr;
endmodule
