// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`endmodule //Required to pair up with already used "`module" in file assert_proposition.vlib

//Module to be replicated for assert checks
//This module is bound to the PSL vunits with assert checks
module assert_proposition_assert (reset_n, test_expr, xzdetect_bit, xzcheck_enable);
       input reset_n, test_expr;
       input xzdetect_bit, xzcheck_enable;
endmodule
