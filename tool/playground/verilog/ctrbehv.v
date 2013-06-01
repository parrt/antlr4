
module ctr( q, clk, r );

   output [3:0] q;
   input  clk;
   input  r;

   reg [3:0] q;
      

   always @( posedge clk )
     if ( r )
       q = 4'b0000;
     else
       q = q + 1;

endmodule // ctr

module top();
   
   reg clk;
   reg r;
   wire [3:0] q;

   ctr c0( q, clk, r );

   initial
     clk = 1'b0;
   always
     #5 clk = ~clk;

   initial
     begin
	r = 1'b1;
	#15 r = 1'b0;
	#180 r = 1'b1;
	#10 r = 1'b0;
	#20 $finish;
     end

   initial
     $monitor( $time, " Output q=%d", q );

endmodule // top

	
   

   
   
