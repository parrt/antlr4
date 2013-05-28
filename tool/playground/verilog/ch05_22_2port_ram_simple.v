// Listing 5.22
module altera_dual_port_ram_simple
   #(
    parameter DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 10  // number of address bits
   )
   (
    input wire clk,
    input wire we,
    input wire [ADDR_WIDTH-1:0] w_addr, r_addr,
    input wire [DATA_WIDTH-1:0] d,
    output wire [DATA_WIDTH-1:0] q
   );

   // signal declaration
   reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
   reg [ADDR_WIDTH-1:0] addr_reg;

   // body
   // write operation
   always @(posedge clk)
   begin
      if (we)
         ram[w_addr] <= d;
      addr_reg <= r_addr;
   end
   
   // read operation
   assign q = ram[addr_reg];
endmodule