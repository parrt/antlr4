// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_no_contention (clock, reset, enable, test_expr, driver_enables, fire);

  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter min_quiet      = 0;
  parameter max_quiet      = 0;
  parameter num_drivers    = 2;
  parameter width          = 2;
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                            clock, reset, enable;
  input  [width-1 : 0]             test_expr;
  input  [num_drivers-1 : 0]       driver_enables;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_NO_CONTENTION";







`endmodule // ovl_no_contention

