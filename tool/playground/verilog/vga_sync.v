module vga_sync
   (
    input wire clk, reset,
    output wire hsync_i, vsync_i, video_on_i, p_tick,
    output wire [9:0] pixel_x, pixel_y
   );

   // constant declaration
   // VGA 640-by-480 sync parameters
   localparam HD = 640; // horizontal display area
   localparam HF = 16 ; // horizontal front porch
   localparam HB = 48 ; // horizontal back porch
   localparam HR = 96 ; // horizontal retrace
   localparam VD = 480; // vertical display area
   localparam VF = 10;  // vertical front porch
   localparam VB = 33;  // vertical back porch
   localparam VR = 2;   // vertical retrace

   // mod-2 counter
   reg mod2_reg;
   wire mod2_next;
   // sync counters
   reg [9:0] h_count_reg, h_count_next;
   reg [9:0] v_count_reg, v_count_next;
   // status signal
   wire h_end, v_end, pixel_tick;

   // body
   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            mod2_reg <= 1'b0;
            v_count_reg <= 0;
            h_count_reg <= 0;
         end
      else
         begin
            mod2_reg <= mod2_next;
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
         end

   // mod-2 circuit to generate 25 MHz enable tick
   assign mod2_next = ~mod2_reg;
   assign pixel_tick = mod2_reg;

   // status signals
   // end of horizontal counter (799)
   assign h_end = (h_count_reg==(HD+HF+HB+HR-1));
   // end of vertical counter (524)
   assign v_end = (v_count_reg==(VD+VF+VB+VR-1));

   // next-state logic of mod-800 horizontal sync counter
   always @*
      if (pixel_tick)  // 25 MHz pulse
         if (h_end)
            h_count_next = 0;
         else
            h_count_next = h_count_reg + 1;
      else
         h_count_next = h_count_reg;

   // next-state logic of mod-525 vertical sync counter
   always @*
      if (pixel_tick & h_end)
         if (v_end)
            v_count_next = 0;
         else
            v_count_next = v_count_reg + 1;
      else
         v_count_next = v_count_reg;

   // h_sync 
   assign hsync_i = h_count_reg<(HD+HF) || h_count_reg>(HD+HF+HR-1);
   // vh_sync                                                                                                                                                                                                               asserted between 490 and 491
   assign vsync_i = v_count_reg<(VD+VF) || v_count_reg>(VD+VF+VR-1);

   // video on/off
   assign video_on_i = (h_count_reg<HD) && (v_count_reg<VD);

   // output
   assign pixel_x = h_count_reg;
   assign pixel_y = v_count_reg;
   assign p_tick = pixel_tick;
endmodule
