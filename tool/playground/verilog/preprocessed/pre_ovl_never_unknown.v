// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.


// Accellera Standard V2.5 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2010. All rights reserved.
















  #ifdef OVL_COVER_ON
    #ifdef OVL_SHARED_CODE
    #else
      #define OVL_SHARED_CODE
    #endif
  #endif


// specifying interface for System Verilog




  #define module module
  #define endmodule endmodule


// Selecting global reset or local reset for the checker reset signal



  #define OVL_RESET_SIGNAL reset_n


// active edges





// default edge_type (ovl_always_on_edge)



  #define OVL_EDGE_TYPE_DEFAULT `0



// severity levels





// default severity level



  #define OVL_SEVERITY_DEFAULT `1


// coverage levels (note that 3 would set both SANITY & BASIC)







// default coverage level



  #define OVL_COVER_DEFAULT `2


// property type






// fire bit positions (first two also used for xcheck input to error_t)




// auto_bin_max for covergroups, default value is set as per LRM recommendation



// default property type



  #define OVL_PROPERTY_DEFAULT `0


// default message



  #define OVL_MSG_DEFAULT "VIOLATION"


// necessary condition




// default necessary_condition (ovl_cycle_sequence)



  #define OVL_NECESSARY_CONDITION_DEFAULT `0


// action on new start




// default action_on_new_start (e.g. ovl_change)



  #define OVL_ACTION_ON_NEW_START_DEFAULT `0


// inactive levels




// default inactive (ovl_one_cold)



  #define OVL_INACTIVE_DEFAULT `2


// new interface (ovl 2)












  #define OVL_CLOCK_EDGE_DEFAULT `1














// ovl runtime after fatal error






// Covergroup define







// Ensure x-checking logic disabled if ASSERTs are off


  #define OVL_XCHECK_OFF
  #define OVL_IMPLICIT_XCHECK_OFF



`module ovl_never_unknown (clock, reset, enable, qualifier, test_expr, fire);

  parameter severity_level = OVL_SEVERITY_DEFAULT;
  parameter width          = 1;
  parameter property_type  = OVL_PROPERTY_DEFAULT;
  parameter msg            = OVL_MSG_DEFAULT;
  parameter coverage_level = OVL_COVER_DEFAULT;

  parameter clock_edge     = OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = ``0;
  parameter gating_type    = ``1;

  input                          clock, reset, enable;
  input                          qualifier;
  input  [width-1:0]             test_expr;
  output [`3-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_NEVER_UNKNOWN";

  #include "std_ovl_reset.h"
  #include "std_ovl_clock.h"
  #include "std_ovl_cover.h"
  #include "std_ovl_task.h"
  #include "std_ovl_init.h"













  assign fire = {fire_cover, fire_xcheck, fire_2state};
  `endmodule // ovl_never_unknown
