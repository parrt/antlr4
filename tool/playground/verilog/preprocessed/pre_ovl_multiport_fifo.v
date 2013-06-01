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







module ovl_multiport_fifo (clock, reset, enable, enq, deq, enq_data, deq_data, full, empty,
                            preload, fire);

  parameter severity_level   = 1;
  parameter width            = 1;
  parameter depth            = 2;
  parameter enq_count        = 2;
  parameter deq_count        = 2;
  parameter preload_count    = 0;
  parameter pass_thru        = 0;
  parameter registered       = 0;
  parameter high_water_mark  = 0;
  parameter enq_latency      = 0;
  parameter deq_latency      = 0;
  parameter value_check        = 0;
  parameter full_check         = 0;
  parameter empty_check        = 0;
  parameter property_type    = 0;
  parameter msg              = "VIOLATION";
  parameter coverage_level   = 2;

  parameter clock_edge       = 1;
  parameter reset_polarity   = 0;
  parameter gating_type      = 1;

  input                            clock, reset, enable;
  input                            full, empty;
  input  [enq_count-1 : 0]         enq;
  input  [deq_count-1 : 0]         deq;
  input  [enq_count*width-1:0]     enq_data;
  input  [deq_count*width-1:0]     deq_data;
  input  [(preload_count?(preload_count*width):1) -1:0] preload;
  output [3-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "ASSERT_MULTIPORT_FIFO";












endmodule // ovl_multiport_fifo

