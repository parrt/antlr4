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







module ovl_cycle_sequence (clock, reset, enable, event_sequence, fire);

  parameter severity_level      = 1;
  parameter num_cks             = 2;
  parameter necessary_condition = 0;
  parameter property_type       = 0;
  parameter msg                 = "VIOLATION";
  parameter coverage_level      = 2;

  parameter clock_edge     = 1;
  parameter reset_polarity = 0;
  parameter gating_type    = 1;

  input                          clock, reset, enable;
  input  [num_cks-1:0]           event_sequence;
  output [3-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_CYCLE_SEQUENCE";









  // Sanity Checks
  initial begin
    if (num_cks < 2) begin
      ovl_error_t(0,"Illegal value for parameter num_cks which must be set to value greater than 1");
    end
  end














  assign fire = {fire_cover, fire_xcheck, fire_2state};
  endmodule // ovl_cycle_sequence
