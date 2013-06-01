// Listing 3.3
module eq_top
   (
    input wire clk, 
    input wire [3:0] sw,
    output wire [0:0] ledr
   );

   // body
   // instantiate 2-bit comparator 
   eq2 eq_unit
      (.a(sw[3:2]), .b(sw[1:0]), .aeqb(ledr[0]));
endmodule
