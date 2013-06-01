
module threebitcounter (input clk, input rst,
    input ld, input inc,
    input [2:0] data_in,
    output reg [2:0] data_out);

   always @(posedge clk)
      if (rst)
         data_out = 0;
      else
         if (ld)
            data_out = data_in;
            else
               if (inc) begin
                  // synthesis translate_off
                  if (data_out == 3'h7)
                     $display ("ERROR: Overflow");
                  // synthesis translate_on
                  data_out = data_out + 1;
                  end
endmodule // threebitcounter
