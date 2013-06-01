// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





`endmodule //Required to pair up with already used "`module" in file assert_increment.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_increment_assert (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 8;
       parameter value = 1;
       input clk, reset_n;
       input [width-1:0] test_expr;
       input xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_increment_assume (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 8;
       parameter value = 1;
       input clk, reset_n;
       input [width-1:0] test_expr;
       input xzcheck_enable;
endmodule


//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_increment_cover (clk, reset_n, test_expr);
       parameter width = 8;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n;
       input [width-1:0] test_expr;
endmodule

