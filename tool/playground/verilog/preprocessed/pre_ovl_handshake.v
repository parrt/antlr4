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







module ovl_handshake (clock, reset, enable, req, ack, fire);

  parameter severity_level = 1;
  parameter min_ack_cycle  = 0;
  parameter max_ack_cycle  = 0;
  parameter req_drop       = 0;
  parameter deassert_count = 0;
  parameter max_ack_length = 0;
  parameter property_type  = 0;
  parameter msg            = "VIOLATION";
  parameter coverage_level = 2;

  parameter clock_edge     = 1;
  parameter reset_polarity = 0;
  parameter gating_type    = 1;

  input                          clock, reset, enable;
  input                          req;
  input                          ack;
  output [3-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_HANDSHAKE";





















  endmodule // ovl_handshake
