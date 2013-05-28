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
/* This is our tiny request circuit */

module req_ack (
    input clk,
    input reset_n,
    input  ack,
    output reg req);


   always @(posedge clk) begin
      if (!reset_n) begin
         req <= 0;
      end else
        if (!req)
         req <= 1;
        else if (ack)
          req <= 0;
      end

endmodule // req_ack




