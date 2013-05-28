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
module assertion (input clk, input rst, input ld, input inc,
                 input [2:0] data_in, input [2:0] data_out,
                 output error);

wire [`OVL_FIRE_WIDTH-1:0] overflow_fire,
                           ld_on_inc_fire;

assign error = overflow_fire[`OVL_FIRE_2STATE] |
               ld_on_inc_fire[`OVL_FIRE_2STATE];


ovl_never #(.reset_polarity(`OVL_ACTIVE_HIGH))

U_counter_overflow
         (.clock(clk), .reset(rst), .enable(~rst), .fire(overflow_fire),

          .test_expr((data_out == 3'h7) && inc));



ovl_implication#(.reset_polarity(`OVL_ACTIVE_HIGH))

U_no_ld_on_inc
         (.clock(clk), .reset(rst), .enable(~rst), .fire(ld_on_inc_fire),

         .antecedent_expr(inc),
         .consequent_expr(~ld));

endmodule

