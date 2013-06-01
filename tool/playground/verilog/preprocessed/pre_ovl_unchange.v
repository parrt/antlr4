// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_unchange (clock, reset, enable, start_event, test_expr, fire);

  parameter severity_level      = `OVL_SEVERITY_DEFAULT;
  parameter width               = 1;
  parameter num_cks             = 1;
  parameter action_on_new_start = `OVL_ACTION_ON_NEW_START_DEFAULT;
  parameter property_type       = `OVL_PROPERTY_DEFAULT;
  parameter msg                 = `OVL_MSG_DEFAULT;
  parameter coverage_level      = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                          clock, reset, enable;
  input                          start_event;
  input  [width-1:0]             test_expr;
  output [`OVL_FIRE_WIDTH-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_UNCHANGE";




  // Sanity Checks
  initial begin
    if (~((action_on_new_start == `OVL_IGNORE_NEW_START)   ||
          (action_on_new_start == `OVL_RESET_ON_NEW_START) ||
          (action_on_new_start == `OVL_ERROR_ON_NEW_START)))
    begin
      ovl_error_t(`OVL_FIRE_2STATE,"Illegal value set for parameter action_on_new_start");
    end
    //
    if (num_cks <= 0) begin
      ovl_error_t(`OVL_FIRE_2STATE,"Illegal value for parameter num_cks which must be set to value greater than 0");
    end    
  end
















  `endmodule // ovl_unchange
