// Listing 6.7
module debounce_test
   (
    input wire clk, reset,
    input wire [0:0] sw,
    input wire [0:0] key,
    output wire [6:0] hex3, hex2, hex1, hex0
   );

   // signal declaration
   reg [7:0]  b_reg, d_reg;
   wire [7:0] b_next, d_next;
   reg  sw_reg, db_reg;
   wire db_level, db_tick, btn_tick, clr;

   // instantiate debouncing circuit
   db_fsm db_unit
      (.clk(clk), .reset(reset), .sw(sw[0]), .db(db_level));
   // instantiate four instances of 7-seg LED decoders
   bin_to_sseg disp_unit_0
      (.bin(d_reg[3:0]), .sseg(hex0));
   bin_to_sseg disp_unit_1
      (.bin(d_reg[7:4]), .sseg(hex1));
   bin_to_sseg disp_unit_2
      (.bin(b_reg[3:0]), .sseg(hex2));
   bin_to_sseg disp_unit_3
      (.bin(b_reg[7:4]), .sseg(hex3));

   // edge detection circuits
   always @(posedge clk)
      begin
         sw_reg <= sw[0];
         db_reg <= db_level;
      end
   assign btn_tick = ~sw_reg & sw[0];
   assign db_tick = ~db_reg & db_level;

   // two counters
   assign clr = ~key[0];
   always @(posedge clk)
      begin
         b_reg <= b_next;
         d_reg <= d_next;
      end
   assign b_next = (clr)      ? 8'b0 :
                   (btn_tick) ? b_reg + 1 : b_reg;
   assign d_next = (clr)      ? 8'b0 :
                   (db_tick)  ? d_reg + 1 : d_reg;
endmodule
