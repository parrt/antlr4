// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



//Module to be replicated for assert checks
//This module is bound to the PSL vunits with assert checks
module assert_always_on_edge_assert (clk, reset_n, test_expr, sampling_event, noedge_type, posedge_type, negedge_type, anyedge_type, xzcheck_enable);
       input clk, reset_n, test_expr, sampling_event, noedge_type, posedge_type, negedge_type, anyedge_type,
             xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_always_on_edge_assume (clk, reset_n, test_expr, sampling_event, noedge_type, posedge_type, negedge_type, anyedge_type, xzcheck_enable);
       input clk, reset_n, test_expr, sampling_event, noedge_type, posedge_type, negedge_type, anyedge_type,
             xzcheck_enable;
endmodule
