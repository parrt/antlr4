//Listing 8.19
`timescale 1 ns/10 ps

module bin_counter_tb3();

   //  declaration
   localparam  T=20; // clock period
   wire clk, reset;
   wire syn_clr, load, en, up;
   wire [2:0] d;
   wire max_tick, min_tick;
   wire [2:0] q;

   // uut instantiation
     (.clk(clk), .reset(reset), .syn_clr(syn_clr),
      .load(load), .en(en), .up(up), .d(d),
      .max_tick(max_tick), .min_tick(min_tick), .q(q));

   // test vector generator
     (.clk(clk), .reset(reset), .syn_clr(syn_clr),
      .load(load), .en(en), .up(up), .d(d));

   // bin_monitor instantiation
     (.clk(clk), .reset(reset), .syn_clr(syn_clr),
      .load(load), .en(en), .up(up), .d(d),
      .max_tick(max_tick), .min_tick(min_tick), .q(q));

endmodule
