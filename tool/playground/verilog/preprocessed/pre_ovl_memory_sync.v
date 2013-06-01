// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.


// Accellera Standard V2.5 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2010. All rights reserved.
























// specifying interface for System Verilog








// Selecting global reset or local reset for the checker reset signal






// active edges





// default edge_type (ovl_always_on_edge)







// severity levels





// default severity level






// coverage levels (note that 3 would set both SANITY & BASIC)







// default coverage level






// property type






// fire bit positions (first two also used for xcheck input to error_t)




// auto_bin_max for covergroups, default value is set as per LRM recommendation



// default property type






// default message






// necessary condition




// default necessary_condition (ovl_cycle_sequence)






// action on new start




// default action_on_new_start (e.g. ovl_change)






// inactive levels




// default inactive (ovl_one_cold)






// new interface (ovl 2)



























// ovl runtime after fatal error






// Covergroup define







// Ensure x-checking logic disabled if ASSERTs are off







module ovl_memory_sync (reset, enable, start_addr, end_addr, r_clock, ren, raddr, rdata,
                         w_clock, wen, waddr, wdata, fire);

  parameter severity_level   = 1;
  parameter data_width       = 1;
  parameter addr_width       = 1;
  parameter mem_size         = 2;
  parameter addr_check         = 1;
  parameter init_check         = 1;
  parameter conflict_check     = 0;
  parameter pass_thru        = 0;
  parameter one_read_check        = 0;
  parameter one_write_check       = 0;
  parameter value_check        = 0;
  parameter property_type    = 0;
  parameter msg              = "VIOLATION";
  parameter coverage_level   = 2;

  parameter wen_edge     = 1;
  parameter ren_edge     = 1;
  parameter reset_polarity   = 0;
  parameter gating_type      = 1;

  input                            reset, enable;
  input                            ren, wen, r_clock, w_clock;
  input  [addr_width-1 : 0]        start_addr;
  input  [addr_width-1 : 0]        end_addr;
  input  [addr_width-1 : 0]        raddr;
  input  [data_width-1 : 0]        rdata;
  input  [addr_width-1 : 0]        waddr;
  input  [data_width-1 : 0]        wdata;
  output [3-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_MEMORY_SYNC";




  // latch based gated clock

  wire rd_gclk, wr_gclk;
  reg  rd_clken, wr_clken;

  always @ (r_clock or enable) begin
    if (r_clock == 1'b0)
      rd_clken <= enable;
  end

  always @ (w_clock or enable) begin
    if (w_clock == 1'b0)
      wr_clken <= enable;
  end

  assign rd_gclk = (gating_type == 1) ? r_clock & rd_clken : r_clock;
  assign wr_gclk = (gating_type == 1) ? w_clock & wr_clken : w_clock;


  // clk (programmable edge)

  wire   rd_clk, wr_clk;

  assign rd_clk = (ren_edge == 1) ? rd_gclk : ~rd_gclk;
  assign wr_clk = (wen_edge == 1) ? wr_gclk : ~wr_gclk;


  // reset_n (programmable polarity & optional gating)

  wire   reset_n;
  assign reset_n = (gating_type == 2) ? ((reset_polarity == 0) ? reset & enable : ~reset & enable)
                                                    : ((reset_polarity == 0) ? reset          : ~reset);











endmodule // ovl_memory_sync

