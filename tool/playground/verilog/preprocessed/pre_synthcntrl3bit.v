
// Accellera Standard V2.5 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2010. All rights reserved.
























// specifying interface for System Verilog








// Selecting global reset or local reset for the checker reset signal






// active edges





// default edge_type (ovl_always_on_edge)







// severity levels





// default severity level






// coverage levels (note that 3 would set both SANITY & BASIC)







// default coverage level






// property type






// fire bit positions (first two also used for xcheck input to error_t)




// auto_bin_max for covergroups, default value is set as per LRM recommendation



// default property type






// default message






// necessary condition




// default necessary_condition (ovl_cycle_sequence)






// action on new start




// default action_on_new_start (e.g. ovl_change)






// inactive levels




// default inactive (ovl_one_cold)






// new interface (ovl 2)



























// ovl runtime after fatal error






// Covergroup define







// Ensure x-checking logic disabled if ASSERTs are off







module threebitcounter (input clk, input rst, 
    input ld, input inc, 
    input [2:0] data_in,
    output reg [2:0] data_out
    ,output wire assert_fire);
    

	assign assert_fire = 0;		


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

