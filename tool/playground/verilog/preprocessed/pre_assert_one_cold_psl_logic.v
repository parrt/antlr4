// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.










`endmodule //Required to pair up with already used "`module" in file assert_one_cold.vlib

//Module to be replicated for assert checks
//This module is bound to the PSL vunits with assert checks
module assert_one_cold_assert (clk, reset_n, test_expr, xzcheck_enable, inactive_val);
       parameter width = 8;
       parameter inactive = `OVL_ONE_COLD;
       input clk, reset_n, xzcheck_enable, inactive_val;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_one_cold_assume (clk, reset_n, test_expr, xzcheck_enable, inactive_val);
       parameter width = 8;
       parameter inactive = `OVL_ONE_COLD;
       input clk, reset_n, xzcheck_enable, inactive_val;
       input [width-1:0] test_expr;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_one_cold_cover (clk, reset_n, test_expr, one_colds_checked, inactive_val);
       parameter width = 8;
       parameter inactive = `OVL_ONE_COLD;
       parameter OVL_COVER_SANITY_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n, inactive_val;
       input [width-1:0] test_expr, one_colds_checked;
endmodule
