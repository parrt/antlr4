// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.




`endmodule //Required to pair up with already used "`module" in file assert_quiescent_state.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_quiescent_state_assert (clk, reset_n, state_expr, check_value, sample_event, end_of_simulation, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, sample_event;
       input [width-1:0]  state_expr, check_value;
       input end_of_simulation;
input xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_quiescent_state_assume (clk, reset_n, state_expr, check_value, sample_event, end_of_simulation, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, sample_event;
       input [width-1:0] state_expr, check_value;
       input end_of_simulation;
       input xzcheck_enable;
endmodule

