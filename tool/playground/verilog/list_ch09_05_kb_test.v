//Listing 9.5
module kb_test
   (
    input wire clk, reset,
    input wire ps2d, ps2c,
    output wire tx
   );

   // signal declaration
   wire [7:0] key_code, ascii_code;
   wire kb_not_empty, kb_buf_empty;

   // body
   // instantiate keyboard scan code circuit
   kb_code kb_code_unit
      (.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c),
       .rd_key_code(kb_not_empty), .key_code(key_code),
       .kb_buf_empty(kb_buf_empty));

   // instantiate UART
   uart uart_unit
      (.clk(clk), .reset(reset), .rd_uart(1'b0),
       .wr_uart(kb_not_empty), .rx(1'b1), .w_data(ascii_code),
       .tx_full(), .rx_empty(), .r_data(), .tx(tx));

   // instantiate key-to-ascii code conversion circuit
   key2ascii k2a_unit
      (.key_code(key_code), .ascii_code(ascii_code));

   assign kb_not_empty = ~kb_buf_empty;

endmodule