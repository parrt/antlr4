// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.



`module ovl_multiport_fifo (clock, reset, enable, enq, deq, enq_data, deq_data, full, empty,
                            preload, fire);

  parameter severity_level   = `OVL_SEVERITY_DEFAULT;
  parameter width            = 1;
  parameter depth            = 2;
  parameter enq_count        = 2;
  parameter deq_count        = 2;
  parameter preload_count    = 0;
  parameter pass_thru        = 0;
  parameter registered       = 0;
  parameter high_water_mark  = 0;
  parameter enq_latency      = 0;
  parameter deq_latency      = 0;
  parameter value_check        = 0;
  parameter full_check         = 0;
  parameter empty_check        = 0;
  parameter property_type    = `OVL_PROPERTY_DEFAULT;
  parameter msg              = `OVL_MSG_DEFAULT;
  parameter coverage_level   = `OVL_COVER_DEFAULT;

  parameter clock_edge       = `OVL_CLOCK_EDGE_DEFAULT;
  parameter reset_polarity   = `OVL_RESET_POLARITY_DEFAULT;
  parameter gating_type      = `OVL_GATING_TYPE_DEFAULT;

  input                            clock, reset, enable;
  input                            full, empty;
  input  [enq_count-1 : 0]         enq;
  input  [deq_count-1 : 0]         deq;
  input  [enq_count*width-1:0]     enq_data;
  input  [deq_count*width-1:0]     deq_data;
  input  [(preload_count?(preload_count*width):1) -1:0] preload;
  output [`OVL_FIRE_WIDTH-1 : 0]   fire;

  // Parameters that should not be edited
  parameter assert_name = "ASSERT_MULTIPORT_FIFO";







`endmodule // ovl_multiport_fifo

