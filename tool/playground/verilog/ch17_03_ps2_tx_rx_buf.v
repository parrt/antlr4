module ps2_tx_rx_buf
   #(parameter W_SIZE = 2)   // # address bits in FIFO buffer
   (
    input wire clk, reset,
    input wire wr_ps2, rd_ps2_packet,
    input wire [7:0] ps2_tx_data,
    output wire [7:0] ps2_rx_data,
    output wire ps2_tx_idle, ps2_rx_buf_empty,
    inout wire ps2d, ps2c
   );

   // signal declaration
   wire rx_idle, tx_idle, rx_done_tick;
   wire [7:0] rx_data;

   // body
   // instantiate ps2 transmitter
   ps2_tx ps2_tx_unit
      (.clk(clk), .reset(reset), .wr_ps2(wr_ps2),
       .rx_idle(rx_idle), .din(ps2_tx_data), .ps2d(ps2d), .ps2c(ps2c),
       .tx_idle(tx_idle), .tx_done_tick());
   // instantiate ps2 receiver
   ps2_rx ps2_rx_unit
      (.clk(clk), .reset(reset), .rx_en(tx_idle),
       .ps2d(ps2d), .ps2c(ps2c), .rx_idle(rx_idle),
       .rx_done_tick(rx_done_tick), .dout(rx_data));
   // instantiate FIFO buffer
   fifo #(.DATA_WIDTH(8), .ADDR_WIDTH(W_SIZE)) fifo_unit
      (.clk(clk), .reset(reset), .rd(rd_ps2_packet),
       .wr(rx_done_tick), .w_data(rx_data), .empty(ps2_rx_buf_empty),
       .full(), .r_data(ps2_rx_data));
   //output 
   assign ps2_tx_idle = tx_idle;
endmodule
