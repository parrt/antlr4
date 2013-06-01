// Listing 5.17
module stop_watch_test
   (
    input wire clk,
    input wire [1:0] key,
    output wire [7:0] hex3, hex2, hex1, hex0
   );

   // signal declaration
   wire [3:0]  d2, d1, d0;
   wire go, clr;

   //body
   assign go = ~key[1];
   assign clr = ~key[0];

   // instantiate stopwatch
   stop_watch_if counter_unit
      (.clk(clk), .go(go), .clr(clr),
       .d2(d2), .d1(d1), .d0(d0) );

   // instantiate four instances of 7-seg LED decoders
   bin_to_sseg disp_unit_0
      (.bin(d0), .sseg(hex0));
   bin_to_sseg disp_unit_1
      (.bin(d1), .sseg(hex1));
   bin_to_sseg disp_unit_2
      (.bin(d2), .sseg(hex2));
   bin_to_sseg disp_unit_3
      (.bin(4'b000), .sseg(hex3));
endmodule
