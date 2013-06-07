// Listing 4.17
module sm_add_test
   (
    input wire [7:0] sw,
    output wire [6:0] hex3, hex2, hex1, hex0
   );

   // signal declaration
   wire [3:0] sum, oct;

   //body
   // instantiate adder
   sign_mag_add #(.N(4)) sm_adder_unit
     (.a(sw[3:0]), .b(sw[7:4]), .sum(sum));
   //  magnitude displayed on rightmost 7-seg LED
   assign oct = {1'b0, sum[2:0]};
   // instantiate hex decoder
   bin_to_sseg disp_unit_0
      (.bin(oct), .sseg(hex0));
   // sign displayed on 2nd 7-seg LED
   // middle LED bar on for negative number
   assign hex1 = sum[3] ? 7'b0111111 : 7'b1111111;
   // blank two other LEDs
   assign hex2 = 7'b1111111;
   assign hex3 = 7'b1111111;
endmodule
