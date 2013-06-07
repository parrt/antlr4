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

