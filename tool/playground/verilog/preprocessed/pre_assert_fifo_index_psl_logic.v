// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.




`endmodule //Required to pair up with already used "`module" in file assert_fifo_index.vlib

//Module to be replicated for assert checks
//This module is bound to a PSL vunits with assert checks
module assert_fifo_index_assert (clk, reset_n, push, pop, cnt, xzcheck_enable);
       parameter depth=1;
       parameter push_width = 1;
       parameter pop_width = 1;
       parameter simultaneous_push_pop = 1;
       parameter cnt_reg_width = 1;
       input clk, reset_n;
       input [push_width-1:0] push;
       input [pop_width-1:0] pop;
       input [cnt_reg_width-1:0] cnt;
       input xzcheck_enable;

//Any required modeling layer code for asserted properties here

endmodule

//Module to be replicated for assume checks
//This module is bound to a PSL vunits with assume checks
module assert_fifo_index_assume (clk, reset_n, push, pop, cnt, xzcheck_enable);
       parameter depth=1;
       parameter push_width = 1;
       parameter pop_width = 1;
       parameter simultaneous_push_pop = 1;
       parameter cnt_reg_width = 1;
       input clk, reset_n;
       input [push_width-1:0] push;
       input [pop_width-1:0] pop;
       input [cnt_reg_width-1:0] cnt;
       input xzcheck_enable;

//Any required modeling layer code for assumed properties here

endmodule


//Module to be replicated for cover properties
//This module is bound to a PSL vunit with cover properties
module assert_fifo_index_cover (clk, reset_n, push, pop, cnt);
       parameter depth=1;
       parameter push_width = 1;
       parameter pop_width = 1;
       parameter simultaneous_push_pop = 1;
       parameter cnt_reg_width = 1;
       parameter OVL_COVER_BASIC_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n;
       input [push_width-1:0] push;
       input [pop_width-1:0] pop;
       input [cnt_reg_width-1:0] cnt;

//Any only coverage related modeling layer code for properties here

endmodule
