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







module ovl_arbiter (clock, reset, enable, reqs, priorities, gnts, fire);

  parameter severity_level      = 1;
  parameter width               = 2;
  parameter priority_width      = 1;
  parameter min_cks             = 1;
  parameter max_cks             = 0;
  parameter one_cycle_gnt_check = 1;
  parameter priority_check      = 0;
  parameter arbitration_rule    = 0;
  parameter property_type       = 0;
  parameter msg                 = "VIOLATION";
  parameter coverage_level      = 2;

  parameter clock_edge          = 1;
  parameter reset_polarity      = 0;
  parameter gating_type         = 1;

  input                    clock, reset, enable;
  input  [width-1 : 0]     reqs;
  input  [width-1 : 0]     gnts;
  input  [(width*priority_width)-1 : 0] priorities;
  output [3-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_ARBITER";












endmodule // ovl_arbiter

