
module threebitcounter (input clk, input rst,
   input ld, input inc,
   input [2:0] data_in,
   output reg [2:0] data_out);



threebitcounter_firewall U_FW (.clk(clk), .rst(rst),
               .ld(ld), .inc(inc),
               .data_in(data_in),
               .data_out(data_out));


   always @(posedge clk)
      if (rst)
         data_out = 0;
      else
         if (ld)
            data_out = data_in;
         else if (inc)
            data_out = data_out + 1;
endmodule // threebitcounter
