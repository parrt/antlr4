// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.

  parameter WIDTH_START = 2'b00;
  parameter WIDTH_CKMIN = 2'b01;
  parameter WIDTH_CKMAX = 2'b10;
  parameter WIDTH_IDLE  = 2'b11;

  reg r_test_expr;
  reg [1:0] r_state;
  integer num_cks;



  initial begin
    r_state=WIDTH_START;
    num_cks = 0;
  end






  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
  wire valid_test_expr;
  assign valid_test_expr = ~(test_expr ^ test_expr);
 #endif // OVL_IMPLICIT_XCHECK_OFF






  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
 #ifdef OVL_ASSERT_ON
  always @(posedge clk)
    begin
      if (OVL_RESET_SIGNAL != 1'b0)
        begin
          if (valid_test_expr == 1'b1)
            begin
              // Do Nothing
            end
          else
            ovl_error_t(OVL_FIRE_XCHECK,"test_expr contains X or Z");
        end
    end

 #endif // OVL_ASSERT_ON
 #endif // OVL_IMPLICIT_XCHECK_OFF


