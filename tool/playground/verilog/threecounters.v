/*************************************************************************
   Copyright 2008 Ray Salemi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
**************************************************************************/
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
