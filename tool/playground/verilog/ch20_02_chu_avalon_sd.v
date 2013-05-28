module chu_avalon_sd 
   (
    input wire clk, reset,
    // Avalon MM interface
    input wire [1:0] sd_address,
    input wire sd_chipselect, sd_write,
    input wire [31:0] sd_writedata,
    output wire [31:0] sd_readdata,
    // conduit interface
    output wire sd_cs, sd_clk, sd_di,
    input wire sd_do
   );

   // signal declaration
   wire wr_en, wr_sd, wr_cs, wr_dvsr, sd_ready;
   reg cs_reg;
   reg [7:0] dvsr_reg;
   wire [7:0] sd_out;
   
   // body
   //==================================================================
   // instantiate SPI controller   
   //==================================================================
   spi spi_unit
      (.clk(clk), .reset(reset), 
       .din(sd_writedata[7:0]), .dvsr(dvsr_reg), .dout(sd_out), 
       .wr_sd(wr_sd), .spi_clk(sd_clk), .spi_done_tick(),
       .spi_mosi(sd_di), .spi_miso(sd_do), .spi_idle(sd_ready));
   //==================================================================
   // registers, write decoding, and read
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
   if (reset)
      begin
        cs_reg <= 0;
        dvsr_reg <= 8'hff;    
      end
   else
      begin
        if (wr_cs) 
           cs_reg <=sd_writedata[0];
        if (wr_dvsr)  
           dvsr_reg <=sd_writedata[7:0];
      end 
   // write decoding                      
   assign wr_en = sd_write & sd_chipselect;
   assign wr_cs = (sd_address==2'b01) & wr_en;
   assign wr_dvsr = (sd_address==2'b10) & wr_en;
   assign wr_sd = (sd_address==2'b11) & wr_en;
  // read data 
  assign sd_readdata = {23'b0, sd_ready, sd_out};          
  // output
  assign sd_cs = cs_reg; 
endmodule