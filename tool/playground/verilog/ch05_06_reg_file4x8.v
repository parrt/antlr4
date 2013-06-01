// Listing 5.6
module reg_file_4x8
   (
    input wire clk,
    input wire wr_en,
    input wire [1:0] w_addr, r_addr,
    input wire [7:0] w_data,
    output reg [7:0] r_data
   );

   // constant declaration
   localparam DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 2; // number of address bits

   // signal declaration
   reg [DATA_WIDTH-1:0] array_reg [2**ADDR_WIDTH-1:0];
   reg [2**ADDR_WIDTH-1:0] en;

   // body

   // 4 registers 
   always @(posedge clk)
   begin
      if (en[0])
         array_reg[0] <= w_data;
      if (en[1])
         array_reg[1] <= w_data;
      if (en[2])
         array_reg[2] <= w_data;
      if (en[3])
         array_reg[3] <= w_data;
   end

   // decoding logic for write address 
   always @*
      if (~wr_en) 
         en = 4'b0000;
      else
        case(w_addr)
           2'b00: en = 4'b0001;
           2'b01: en = 4'b0010;
           2'b10: en = 4'b0100;
           2'b11: en = 4'b1000; 
        endcase
   // read output muiplexing 
   always @*
      case(r_addr)
         2'b00: r_data = array_reg[0];
         2'b01: r_data = array_reg[1];
         2'b10: r_data = array_reg[2]; 
         2'b11: r_data = array_reg[3]; 
     endcase
endmodule

