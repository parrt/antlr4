

module threebitcounter (input clk, input rst, 
    input ld, input inc, 
    input [2:0] data_in,
    output reg [2:0] data_out
    ,output wire assert_fire);
    
	assign assert_fire = 0;		

        wire [2:0] 	fire;
        assign 	assert_fire = fire [0];


		    .reset_polarity(`OVL_ACTIVE_HIGH)) 
	  check_overflow
		(.clock(clk),
		 .reset(rst),
		 .enable(1'b1),
		 .test_expr((data_out == 3'h7) && inc),
		 .fire(fire)
		 );		  

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

