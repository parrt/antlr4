// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.





`endmodule //Required to pair up with already used "`module" in file assert_cycle_sequence.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_cycle_sequence_assert (clk, reset_n, event_sequence, seq_queue, xzcheck_enable);
       parameter num_cks = 2;
       parameter necessary_condition = 0;
       input clk, reset_n;
       input [num_cks-1:0] event_sequence, seq_queue;
       input xzcheck_enable;
endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_cycle_sequence_assume (clk, reset_n, event_sequence, seq_queue, xzcheck_enable);
       parameter num_cks = 2;
       parameter necessary_condition = 0;
       input clk, reset_n;
       input [num_cks-1:0] event_sequence, seq_queue;
       input xzcheck_enable;
endmodule


//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_cycle_sequence_cover (clk, reset_n, event_sequence, seq_queue);
       parameter num_cks = 4;
       parameter necessary_condition = 0;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n;
       input [num_cks-1:0] event_sequence, seq_queue;
endmodule
