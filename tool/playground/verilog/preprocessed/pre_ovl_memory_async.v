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







module ovl_memory_async (reset, enable, start_addr, end_addr, ren, raddr, rdata, wen, waddr,
                          wdata, fire);

  parameter severity_level   = 1;
  parameter data_width       = 1;
  parameter addr_width       = 1;
  parameter mem_size         = 2;
  parameter addr_check       = 1;
  parameter init_check         = 1;
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
  input                            ren, wen;
  input  [addr_width-1 : 0]        start_addr;
  input  [addr_width-1 : 0]        end_addr;
  input  [addr_width-1 : 0]        raddr;
  input  [data_width-1 : 0]        rdata;
  input  [addr_width-1 : 0]        waddr;
  input  [data_width-1 : 0]        wdata;

  output [3-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_MEMORY_ASYNC";




  // latch based gated clock

  wire ren_gclk, wen_gclk;
  reg  ren_clken, wen_clken;

  always @ (ren or enable) begin
    if (ren == 1'b0)
      ren_clken <= enable;
  end

  always @ (wen or enable) begin
    if (wen == 1'b0)
      wen_clken <= enable;
  end

  assign ren_gclk = (gating_type == 1) ? ren & ren_clken : ren;
  assign wen_gclk = (gating_type == 1) ? wen & wen_clken : wen;


  // clk (programmable edge)

  wire   ren_clk, wen_clk;

  assign ren_clk = (ren_edge == 1) ? ren_gclk : ~ren_gclk;
  assign wen_clk = (wen_edge == 1) ? wen_gclk : ~wen_gclk;


  // reset_n (programmable polarity & optional gating)

  wire   reset_n;
  assign reset_n = (gating_type == 2) ? ((reset_polarity == 0) ? reset & enable : ~reset & enable)
                                                    : ((reset_polarity == 0) ? reset          : ~reset);












endmodule // ovl_memory_async

