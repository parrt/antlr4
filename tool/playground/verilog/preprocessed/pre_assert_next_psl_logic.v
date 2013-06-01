// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.




`endmodule //Required to pair up with already used "`module" in file assert_next.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_next_assert (clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable);
       parameter num_cks = 1;
       parameter check_overlapping = 1;
       parameter check_missing_start = 1;
       input clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_next_assume (clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable);
       parameter num_cks = 1;
       parameter check_overlapping = 1;
       parameter check_missing_start = 1;
       input clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_next_cover (clk, reset_n, test_expr, start_event, no_overlapping);
       parameter OVL_COVER_BASIC_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n, test_expr, start_event, no_overlapping;
endmodule
