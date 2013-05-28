// top-level Avalon wrapping circuit
// address 
//    0x00: 32-bit dividend (cpu write)
//    0x01: 32-bit divisor (cpu write)
//    0x02: dummy data to start operation (cpu write)  
//    0x03: 32-bit quotient (cpu read)
//    0x04: 32-bit remainder (cpu read)
//    0x05: bit 0: 1-bit ready (cpu read)  
//    0x06: bit 0: 1-bit done_tick (cpu read/write)
module chu_avalon_div_demo 
   #(
     parameter W = 32,
               CBIT = 6  // CBIT=log2(W)+1
    )
   (
    // to be connected to Avalon clock input interface
    input wire clk, reset,
    // to be connected to Avalon MM slave interface
    input wire [2:0] div_address, 
    input wire div_chipselect,
    input wire div_write,
    input wire [W-1:0] div_writedata,
    output wire [W-1:0] div_readdata,
    // to be connected to interrupt sender interface
    output wire div_irq,
    // to be connected to Avalon conduit interface
    output wire [7:0] div_led 
   );

   // signal declaration
   wire div_start, div_ready, set_done_tick, clr_done_tick;
   reg [W-1:0] dvnd_reg, dvsr_reg;
   reg done_tick_reg;
   wire [W-1:0] quo, rmd;
   wire  wr_en, wr_dvnd, wr_dvsr;
   
   // body
   //==================================================================
   // instantiate division circuit  
   //==================================================================
   div #(.W(W), .CBIT(CBIT)) d_unit
     (.clk(clk), .reset(1'b0), .start(div_start),
      .dvsr(dvsr_reg), .dvnd(dvnd_reg), .quo(quo), .rmd(rmd),
      .ready(div_ready), .done_tick(set_done_tick));

   //==================================================================
   // register, write decoding, and read multiplexing
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            dvnd_reg <= 0;
            dvsr_reg <= 0;
            done_tick_reg <= 1'b0;
         end
      else
         begin
           if (wr_dvnd)
              dvnd_reg <= div_writedata;
           if (wr_dvsr)
              dvsr_reg <= div_writedata;
           if (set_done_tick)
              done_tick_reg <= 1'b1;
           else if (clr_done_tick)
              done_tick_reg <= 1'b0;
         end
   // write decoding logic
   assign wr_en = div_write & div_chipselect;           
   assign wr_dvnd = (div_address==3'b000) & wr_en;
   assign wr_dvsr = (div_address==3'b001) & wr_en;
   assign div_start = (div_address==3'b010) & wr_en;
   assign clr_done_tick = (div_address==3'b110) & wr_en; 
   // read multiplexing logic
   assign div_readdata = (div_address==3'b011) ? quo :
                         (div_address==3'b100) ? rmd :
                         (div_address==3'b101) ? {31'b0, div_ready} :
                                                 {31'b0, done_tick_reg};
   // conduit signals
   assign div_led = rmd[7:0];  // assume that W > 7
   // interrupt signals
   assign div_irq = done_tick_reg;
endmodule