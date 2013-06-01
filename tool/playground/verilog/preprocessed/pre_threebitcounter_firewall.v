
module threebitcounter_firewall(
      input clk, input rst, input ld, input inc, input [2:0] data_in,
      input [2:0] data_out);


always @(posedge clk)
   if (!rst && !ld && inc)
     assert(data_out < 3'h7);
endmodule


