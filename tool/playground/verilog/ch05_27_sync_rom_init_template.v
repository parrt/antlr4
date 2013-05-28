// Listing 5.27
module altera_sync_rom_init_template
   (
    input wire clk,
    input wire [3:0] addr,
    output wire [6:0] data
   );

   // signal declaration
   reg [6:0] ram [0:15]; // ascending range
   reg [6:0] data_reg;
   
   // load initial values from file led_pattern.txt
   // content of led_pattern.txt:
   // 1000000 1111001 0100100 0110000 0011001 0010010 0000010 1111000
   // 0000000 0010000 0001000 0000011 1000110 0100001 0000110 0001110
   initial 
      $readmemb("led_pattern.txt", ram);
   
   // body
   always @(posedge clk)
      data_reg <= ram[addr];
   // read operation
   assign data = data_reg;
endmodule