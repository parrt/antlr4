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

module tb_top;

reg clk, rst;
wire [2:0] data_out;

threebitcounter DUT (.clk(clk), 
                     .rst(rst),
                     .ld(1'b0),
                     .inc(1'b1),
                     .data_in(3'b0),
                     .data_out(data_out));

always #10 clk = ~clk;

initial
  begin
    $monitor ($time,,"data_out: ",data_out);
    rst = 1'b1;
    clk = 1'b0;
    @(posedge clk);
    @(negedge clk);
    rst = 1'b0;
    #200;
    $finish;
  end
  
endmodule
