// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_req_requires (clock, reset, enable, req_trigger, req_follower, resp_leader,
                          resp_trigger, fire);

  parameter severity_level = `OVL_SEVERITY_DEFAULT;
  parameter min_cks        = 1;
  parameter max_cks        = 0;
  parameter property_type  = `OVL_PROPERTY_DEFAULT;
  parameter msg            = `OVL_MSG_DEFAULT;
  parameter coverage_level = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                            clock, reset, enable;
  input                            req_trigger, req_follower;
  input                            resp_trigger, resp_leader;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_REQ_REQUIRES";







`endmodule // ovl_req_requires

