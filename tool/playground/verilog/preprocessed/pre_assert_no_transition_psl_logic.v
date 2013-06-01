// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





`endmodule //Required to pair up with already used "`module" in file assert_no_transition.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_no_transition_assert (clk, reset_n, test_expr, start_state, next_state, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n;
       input [(width-1):0] test_expr, start_state, next_state;
       input xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_no_transition_assume (clk, reset_n, test_expr, start_state, next_state, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n;
       input [(width-1):0] test_expr, start_state, next_state;
       input xzcheck_enable;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_no_transition_cover (clk, reset_n, test_expr, start_state);
       parameter width = 1;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n;
       input [(width-1):0] test_expr, start_state;
endmodule
