
module threecounters(
   input clk,
   input rst,
   input inc,
   input ld,
   input [2:0] data_in,
   output[2:0] data_out,
   output error);

   wire [2:0] data_out1, data_out2;
   wire [1:3] error_bus;

   assign error = |error_bus;

   threebitcounter U1 (
         .clk(clk), .rst(rst), .inc(inc), .ld(ld), .data_in(data_in),
         .data_out(data_out1), .error(error_bus[1]));

   threebitcounter U2 (
         .clk(clk), .rst(rst), .inc(inc), .ld(ld), .data_in(data_out1),
         .data_out(data_out2), .error(error_bus[2]));

   threebitcounter U3 (
         .clk(clk), .rst(rst), .inc(inc), .ld(ld), .data_in(data_out2),
         .data_out(data_out ), .error(error_bus[3]));

 endmodule
