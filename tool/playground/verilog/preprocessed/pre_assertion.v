
module assertion (input clk, input rst, input ld, input inc,
                 input [2:0] data_in, input [2:0] data_out,
                 output error);

wire [`OVL_FIRE_WIDTH-1:0] overflow_fire,
                           ld_on_inc_fire;

assign error = overflow_fire[`OVL_FIRE_2STATE] |
               ld_on_inc_fire[`OVL_FIRE_2STATE];



U_counter_overflow
         (.clock(clk), .reset(rst), .enable(~rst), .fire(overflow_fire),

          .test_expr((data_out == 3'h7) && inc));




U_no_ld_on_inc
         (.clock(clk), .reset(rst), .enable(~rst), .fire(ld_on_inc_fire),

         .antecedent_expr(inc),
         .consequent_expr(~ld));

endmodule

