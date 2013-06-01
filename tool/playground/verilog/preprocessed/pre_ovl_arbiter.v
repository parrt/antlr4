// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_arbiter (clock, reset, enable, reqs, priorities, gnts, fire);

  parameter severity_level      = `OVL_SEVERITY_DEFAULT;
  parameter width               = 2;
  parameter priority_width      = 1;
  parameter min_cks             = 1;
  parameter max_cks             = 0;
  parameter one_cycle_gnt_check = 1;
  parameter priority_check      = 0;
  parameter arbitration_rule    = 0;
  parameter property_type       = `OVL_PROPERTY_DEFAULT;
  parameter msg                 = `OVL_MSG_DEFAULT;
  parameter coverage_level      = `OVL_COVER_DEFAULT;

  parameter clock_edge          = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity      = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type         = `OVL_GATING_TYPE_DEFAULT;

  input                    clock, reset, enable;
  input  [width-1 : 0]     reqs;
  input  [width-1 : 0]     gnts;
  input  [(width*priority_width)-1 : 0] priorities;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_ARBITER";







`endmodule // ovl_arbiter

