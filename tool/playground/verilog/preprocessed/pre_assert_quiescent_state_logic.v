// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.






  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
  wire valid_sample_event;
  wire valid_state_expr;
  wire valid_check_value;

  assign valid_sample_event = ~(sample_event^sample_event);
  assign valid_state_expr = ~((^state_expr)^(^state_expr));
  assign valid_check_value = ~((^check_value)^(^check_value));

 #ifdef OVL_END_OF_SIMULATION
  wire valid_EOS;
  assign valid_EOS = ~(OVL_END_OF_SIMULATION ^ OVL_END_OF_SIMULATION);
 #endif // OVL_END_OF_SIMULATION
 #endif // OVL_IMPLICIT_XCHECK_OFF





  #ifdef OVL_IMPLICIT_XCHECK_OFF
    //Do nothing
  #else
  reg valid_r_sample_event;
 #ifdef OVL_END_OF_SIMULATION
  reg valid_r_EOS;
 #endif // OVL_END_OF_SIMULATION
  always @(posedge clk or negedge OVL_RESET_SIGNAL)
    begin
      if (OVL_RESET_SIGNAL != 1'b1)
        begin
          valid_r_sample_event <= 1'b1;
 #ifdef OVL_END_OF_SIMULATION
          valid_r_EOS <= 1'b1;
 #endif // OVL_END_OF_SIMULATION
        end
      else
        begin
          valid_r_sample_event <= valid_sample_event;
 #ifdef OVL_END_OF_SIMULATION
          valid_r_EOS <= valid_EOS;
 #endif // OVL_END_OF_SIMULATION
        end
    end
 #endif // OVL_IMPLICIT_XCHECK_OFF



