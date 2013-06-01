// Accellera Standard V2.3 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2008. All rights reserved.






    //Do nothing
  wire valid_sample_event;
  wire valid_state_expr;
  wire valid_check_value;

  assign valid_sample_event = ~(sample_event^sample_event);
  assign valid_state_expr = ~((^state_expr)^(^state_expr));
  assign valid_check_value = ~((^check_value)^(^check_value));

  wire valid_EOS;
  assign valid_EOS = ~(`OVL_END_OF_SIMULATION ^ `OVL_END_OF_SIMULATION);





    //Do nothing
  reg valid_r_sample_event;
  reg valid_r_EOS;
  always @(posedge clk or negedge `OVL_RESET_SIGNAL)
    begin
      if (`OVL_RESET_SIGNAL != 1'b1)
        begin
          valid_r_sample_event <= 1'b1;
          valid_r_EOS <= 1'b1;
        end
      else
        begin
          valid_r_sample_event <= valid_sample_event;
          valid_r_EOS <= valid_EOS;
        end
    end



