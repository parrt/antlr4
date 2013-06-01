// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_fifo_index (clock, reset, enable, push, pop, fire);

  parameter severity_level        = `OVL_SEVERITY_DEFAULT;
  parameter depth                 = 1;
  parameter push_width            = 1;
  parameter pop_width             = 1;
  parameter simultaneous_push_pop = 1; // Note: different position than in assert_fifo_index
  parameter property_type         = `OVL_PROPERTY_DEFAULT;
  parameter msg                   = `OVL_MSG_DEFAULT;
  parameter coverage_level        = `OVL_COVER_DEFAULT;

  parameter clock_edge     = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type    = `OVL_GATING_TYPE_DEFAULT;

  input                          clock, reset, enable;
  input  [push_width-1:0]        push;
  input  [pop_width-1:0]         pop;
  output [`OVL_FIRE_WIDTH-1:0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "OVL_FIFO_INDEX";




  // Sanity Checks
  initial begin
    if (depth==0) begin
      ovl_error_t(`OVL_FIRE_2STATE,"Illegal value for parameter depth which must be set to value greater than 0");
    end
  end
















  `endmodule // ovl_fifo_index
