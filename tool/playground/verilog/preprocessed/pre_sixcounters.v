
module sixcounters(
   input clk,rst, ld, inc, select,
   input [2:0] data_in,
   output[2:0] data_out,
   output reg error);

   wire [2:0] data_out0;
   wire       error0, error1;

   always @(posedge clk)
      if (!rst)
         error <= 0;
      else
         if (!error) error <= error0 | error1;


   threecounters U0 (
      .clk(clk), .rst(rst), .ld(ld), .inc(inc), .data_in(data_in),
      .data_out(data_out0), .error(error0));

   threecounters U1(
      .clk(clk), .rst(rst), .ld(ld), .inc(inc), .data_in(data_out0),
      .data_out(data_out ), .error(error1));

endmodule

