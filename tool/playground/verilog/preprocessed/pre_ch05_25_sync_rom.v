// Listing 5.25
module altera_sync_rom_case_template
   (
    input wire clk,
    input wire [3:0] addr,
    output wire [6:0] data
   );

   // signal declaration
   reg [6:0] rom_data, data_reg;

   // body
   always @(posedge clk)
      data_reg <= rom_data;

   always @*
      case (addr)
         4'h0: rom_data = 7'b1000000;
         4'h1: rom_data = 7'b1111001;
         4'h2: rom_data = 7'b0100100;
         4'h3: rom_data = 7'b0110000;
         4'h4: rom_data = 7'b0011001;
         4'h5: rom_data = 7'b0010010;
         4'h6: rom_data = 7'b0000010;
         4'h7: rom_data = 7'b1111000;
         4'h8: rom_data = 7'b0000000;
         4'h9: rom_data = 7'b0010000;
         4'ha: rom_data = 7'b0001000;
         4'hb: rom_data = 7'b0000011;
         4'hc: rom_data = 7'b1000110;
         4'hd: rom_data = 7'b0100001;
         4'he: rom_data = 7'b0000110;
         4'hf: rom_data = 7'b0001110;
      endcase
   
   assign data = data_reg;    
endmodule
