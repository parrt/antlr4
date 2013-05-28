// Listing 4.15
module bin_to_sseg_test
   (
    input wire [7:0] sw,
    output wire [6:0] hex3, hex2, hex1, hex0
   );

   // signal declaration
   wire [7:0] inc;

   // body 
   // increment input
   assign inc = sw + 1;

   // instantiate four instances of 7-seg LED decoders
   bin_to_sseg disp_unit_0
      (.bin(sw[3:0]), .sseg(hex0));
   bin_to_sseg disp_unit_1
      (.bin(sw[7:4]), .sseg(hex1));
   bin_to_sseg disp_unit_2
      (.bin(inc[3:0]), .sseg(hex2));
   bin_to_sseg disp_unit_3
      (.bin(inc[7:4]), .sseg(hex3));
endmodule