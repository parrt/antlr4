// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_next_state (clock, reset, enable, test_expr, curr_state, next_state, fire);

  parameter severity_level   = `OVL_SEVERITY_DEFAULT;
  parameter next_count       = 1;
  parameter width            = 1;
  parameter min_hold         = 1;
  parameter max_hold         = 1;
  parameter disallow         = 0;
  parameter property_type    = `OVL_PROPERTY_DEFAULT;
  parameter msg              = `OVL_MSG_DEFAULT;
  parameter coverage_level   = `OVL_COVER_DEFAULT;

  parameter clock_edge       = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity   = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type      = `OVL_GATING_TYPE_DEFAULT;

  input                            clock, reset, enable;
  input  [width-1 : 0]             test_expr;
  input  [width-1 : 0]             curr_state;
  input  [next_count*width-1:0]    next_state;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "ASSERT_NEXT_STATE";







`endmodule // ovl_next_state

