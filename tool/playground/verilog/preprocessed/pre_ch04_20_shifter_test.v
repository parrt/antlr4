// Listing 4.20
module shifter_test
   (
    input wire [2:0] key,
    input wire [7:0] sw,
    output wire [7:0] ledr
   );

   // instantiate shifter
   barrel_shifter_stage shift_unit
     (.a(sw), .amt(~key), .y(ledr));

endmodule
