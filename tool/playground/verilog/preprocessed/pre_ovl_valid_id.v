// Accellera Standard V2.3 Open Verification Library (OVL.
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







module ovl_valid_id (clock, reset, enable, issued, issued_id, returned, returned_id, flush, flush_id, issued_count, fire);

  parameter severity_level   = 1;
  parameter min_cks          = 1;
  parameter max_cks          = 1;
  parameter width            = 2;
  parameter max_id_instances          = 2;
  parameter max_ids      = 1;
  parameter max_instances_per_id   = 1;
  parameter instance_count_width       = 2;
  parameter property_type    = 0;
  parameter msg              = "VIOLATION";
  parameter coverage_level   = 2;

  parameter clock_edge       = 1;
  parameter reset_polarity   = 0;
  parameter gating_type      = 1;

  input                            clock, reset, enable;
  input                            issued, returned, flush;
  input  [width-1 : 0]             issued_id;
  input  [width-1 : 0]             returned_id;
  input  [width-1 : 0]             flush_id;
  input  [instance_count_width-1 : 0]        issued_count;
  output [3-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_VALID_ID";












endmodule // ovl_valid_id

