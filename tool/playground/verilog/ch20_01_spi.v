module spi 
   (
    input wire clk, reset,
    input wire [7:0] din, dvsr,
    input wire wr_sd,
    output wire [7:0] dout,
    output wire spi_clk, spi_mosi, 
    input wire spi_miso,
    output wire spi_done_tick, spi_idle
   );

   // symbolic state declaration
   localparam [1:0]
      idle  = 2'b00,
      sclk0 = 2'b01,
      sclk1 = 2'b10;
   
   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [7:0] c_reg, c_next;
   reg spi_clk_reg, spi_idle_i, spi_done;
   wire spi_clk_next;
   reg [2:0] bit_reg, bit_next;
   reg [7:0] sin_reg, sin_next, sout_reg, sout_next;

   //body
   // fsmd registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            c_reg <= 0;
            bit_reg <= 0;
            sin_reg <= 0;
            sout_reg <= 0;
            spi_clk_reg <= 1'b0;
         end   
      else 
         begin
            state_reg <= state_next;
            c_reg <=c_next;
            bit_reg <= bit_next;
            sin_reg <= sin_next;
            sout_reg <= sout_next;
            spi_clk_reg <= spi_clk_next;
         end 
   // fsmd next-state logic
   always @*
   begin
      state_next = state_reg;
      c_next = c_reg + 1;  // timer runs continuouisely 
      bit_next = bit_reg;
      sin_next = sin_reg;
      sout_next = sout_reg;
      spi_idle_i = 1'b0;
      spi_done =1'b0;
      case (state_reg)
         idle:
            begin 
               spi_idle_i = 1'b1;
               if (wr_sd)
                  begin 
                     sout_next = din;
                     state_next = sclk0;
                     bit_next = 0;
                     c_next = 8'b1;
                  end   
            end
         sclk0:  
            if (c_reg==dvsr)   // spi_clk 0-to-1
               begin 
                  state_next = sclk1;
                  sin_next = {sin_reg[6:0], spi_miso}; 
                  c_next = 8'b1;
               end
         sclk1:
            if (c_reg==dvsr)  // spi_clk 1-to-0
               if (bit_reg==3'b111)
                  begin
                     spi_done = 1'b1;
                     state_next = idle;
                  end
               else      
                  begin
                     sout_next = {sout_reg[6:0], 1'b0};  
                     state_next = sclk0;
                     bit_next = bit_reg + 1;
                     c_next = 8'b1;
                  end
      endcase;
   end   
   // lookahead output decoding
   assign spi_clk_next = (state_next==sclk1);
   // output
   assign dout = sin_reg;
   assign spi_mosi = sout_reg[7];
   assign spi_clk = spi_clk_reg;
   assign spi_idle = spi_idle_i;
   assign spi_done_tick = spi_done;
endmodule



