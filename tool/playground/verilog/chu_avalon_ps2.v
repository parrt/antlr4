module chu_avalon_ps2 
   #(parameter W_SIZE = 2)   // # address bits in FIFO buffer
   (
    input wire clk, reset,
    // avalon-MM slave interface
    input wire [1:0] ps2_address,
    input wire ps2_chipselect, ps2_write,
    input wire [31:0] ps2_writedata,
    output wire [31:0] ps2_readdata,
    // conduit to/from PS2 port
    inout ps2d, ps2c
   );

   // signal declaration
   wire [7:0] ps2_rx_data;
   wire rd_fifo, ps2_rx_buf_empty;
   wire wr_ps2, ps2_tx_idle;

   // body
   //==================================================================
   // instantiate PS2 controller   
   //==================================================================
   ps2_tx_rx_buf #(.W_SIZE(W_SIZE)) ps2_unit
      (.clk(clk), .reset(reset), .wr_ps2(wr_ps2),
       .rd_ps2_packet(rd_fifo), .ps2_tx_data(ps2_writedata[7:0]),
       .ps2_rx_data(ps2_rx_data), .ps2_tx_idle(ps2_tx_idle),
       .ps2_rx_buf_empty(ps2_rx_buf_empty), 
       .ps2d(ps2d), .ps2c(ps2c)); 
   
   //==================================================================
   // decoding and read multiplexing
   //==================================================================
   // remove an item from FIFO  
   assign rd_fifo = ps2_chipselect & (ps2_address==2'b00) & ps2_write;
   // write data to PS2 transmitting subsystem  
   assign wr_ps2 = ps2_chipselect & (ps2_address==2'b10) & ps2_write;
   //  read data multiplexing
   assign ps2_readdata = (ps2_address==2'b00) ? 
                         {24'b0, ps2_rx_data}:
                         {30'b0, ps2_tx_idle,  ps2_rx_buf_empty}; 
endmodule
