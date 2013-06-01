// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_cycle_sequence (clock, reset, enable, event_sequence, fire);

  parameter severity_level      = `OVL_SEVERITY_DEFAULT;
  parameter num_cks             = 2;
  parameter necessary_condition = `OVL_NECESSARY_CONDITION_DEFAULT;
  parameter property_type       = `OVL_PROPERTY_DEFAULT;
  parameter msg                 = `OVL_MSG_DEFAULT;
  parameter coverage_level      = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                          clock, reset, enable;
  input  [num_cks-1:0]           event_sequence;
  output [`OVL_FIRE_WIDTH-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_CYCLE_SEQUENCE";




  // Sanity Checks
  initial begin
    if (num_cks < 2) begin
      ovl_error_t(`OVL_FIRE_2STATE,"Illegal value for parameter num_cks which must be set to value greater than 1");
    end
  end














  assign fire = {fire_cover, fire_xcheck, fire_2state};
  `endmodule // ovl_cycle_sequence
