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
module threebitcounter (input clk, input rst,
   input ld, input inc,
   input [2:0] data_in,
   output reg [2:0] data_out);


`ifndef ASSERTIONS_OFF
threebitcounter_firewall U_FW (.clk(clk), .rst(rst),
               .ld(ld), .inc(inc),
               .data_in(data_in),
               .data_out(data_out));
`endif

   always @(posedge clk)
      if (rst)
         data_out = 0;
      else
         if (ld)
            data_out = data_in;
         else if (inc)
            data_out = data_out + 1;
endmodule // threebitcounter
