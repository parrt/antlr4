
// Accellera Standard V2.5 Open Verification Library (OVL).
// Accellera Copyright (c) 2005-2010. All rights reserved.
















  #ifdef OVL_COVER_ON
    #ifdef OVL_SHARED_CODE
    #else
      #define OVL_SHARED_CODE
    #endif
  #endif


// specifying interface for System Verilog




  #define module module
  #define endmodule endmodule


// Selecting global reset or local reset for the checker reset signal



  #define OVL_RESET_SIGNAL reset_n


// active edges





// default edge_type (ovl_always_on_edge)



  #define OVL_EDGE_TYPE_DEFAULT `0



// severity levels





// default severity level



  #define OVL_SEVERITY_DEFAULT `1


// coverage levels (note that 3 would set both SANITY & BASIC)







// default coverage level



  #define OVL_COVER_DEFAULT `2


// property type






// fire bit positions (first two also used for xcheck input to error_t)




// auto_bin_max for covergroups, default value is set as per LRM recommendation



// default property type



  #define OVL_PROPERTY_DEFAULT `0


// default message



  #define OVL_MSG_DEFAULT "VIOLATION"


// necessary condition




// default necessary_condition (ovl_cycle_sequence)



  #define OVL_NECESSARY_CONDITION_DEFAULT `0


// action on new start




// default action_on_new_start (e.g. ovl_change)



  #define OVL_ACTION_ON_NEW_START_DEFAULT `0


// inactive levels




// default inactive (ovl_one_cold)



  #define OVL_INACTIVE_DEFAULT `2


// new interface (ovl 2)












  #define OVL_CLOCK_EDGE_DEFAULT `1














// ovl runtime after fatal error






// Covergroup define







// Ensure x-checking logic disabled if ASSERTs are off


  #define OVL_XCHECK_OFF
  #define OVL_IMPLICIT_XCHECK_OFF



module threebitcounter (input clk, input rst, 
    input ld, input inc, 
    input [2:0] data_in,
    output reg [2:0] data_out
    ,output wire assert_fire);
    
    #ifndef OVL_ASSERT_ON
	assign assert_fire = 0;		

    #else
        wire [2:0] 	fire;
        assign 	assert_fire = fire [0];


	ovl_never #(.msg("Counter Overflow"),
		    .reset_polarity(`1)) 
	  check_overflow
		(.clock(clk),
		 .reset(rst),
		 .enable(1'b1),
		 .test_expr((data_out == 3'h7) && inc),
		 .fire(fire)
		 );		  
     #endif

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

