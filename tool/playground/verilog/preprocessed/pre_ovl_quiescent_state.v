// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_quiescent_state (clock, reset, enable, state_expr, check_value, sample_event, fire);

  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter width          = 1;
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                          clock, reset, enable;
  input                          sample_event;
  input  [width-1:0]             state_expr, check_value;
  output [`OVL_FIRE_WIDTH-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_QUIESCENT_STATE";
















  `endmodule // ovl_quiescent_state
