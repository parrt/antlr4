// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





`endmodule //Required to pair up with already used "`module" in file assert_handshake.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_handshake_assert (clk, reset_n, req, ack, first_req, xzcheck_enable);
       parameter min_ack_cycle = 0;
       parameter max_ack_cycle = 0;
       parameter req_drop = 0;
       parameter deassert_count = 0;
       parameter max_ack_length = 0;
       input clk, reset_n, req, ack, first_req, xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_handshake_assume (clk, reset_n, req, ack, first_req, xzcheck_enable);
       parameter min_ack_cycle = 0;
       parameter max_ack_cycle = 0;
       parameter req_drop = 0;
       parameter deassert_count = 0;
       parameter max_ack_length = 0;
       input clk, reset_n, req, ack, first_req, xzcheck_enable;
endmodule

//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_handshake_cover (clk, reset_n, req, ack);
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n, req, ack;
endmodule
