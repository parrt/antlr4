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
`include "std_ovl_defines.h"

module threebitcounter (input clk, input rst, 
    input ld, input inc, 
    input [2:0] data_in,
    output reg [2:0] data_out
    ,output wire assert_fire);
    
    `ifndef OVL_ASSERT_ON
	assign assert_fire = 0;		

    `else
        wire [2:0] 	fire;
        assign 	assert_fire = fire [0];


	ovl_never #(.msg("Counter Overflow"),
		    .reset_polarity(`OVL_ACTIVE_HIGH)) 
	  check_overflow
		(.clock(clk),
		 .reset(rst),
		 .enable(1'b1),
		 .test_expr((data_out == 3'h7) && inc),
		 .fire(fire)
		 );		  
     `endif

always @(posedge clk)
     if (rst) begin
	// synthesis translate_off
	$display ("In threebitinc reset");
	// synthesis translate_on
	data_out = 0;
     end
     else if (ld)
       data_out = data_in;
     else if (inc)begin
	data_out = data_out + 1;
     end
endmodule // threebitcounter

