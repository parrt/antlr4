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
module req_ack_tester (input clk,input reset_n, input req, output reg ack);

   reg   req_flag;
   reg [1:0] cnt;


   always @(negedge clk)
      if (!reset_n) begin
         req_flag = 0;
         ack = 0;
         cnt = 0;
      end
      else if (req)
         if (req_flag)
            if (cnt == 0) begin
               ack = 1;
               req_flag = 0;
               @(negedge clk);
               ack = 0;
             end // cnt == 0
            else //cnt != 0
               cnt = cnt - 1;
         else begin //req_flag == 0
            req_flag = 1;
            cnt = $random;
         end // else: !if(cnt == 0)
endmodule // arb_tb
