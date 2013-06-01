// Listing 5.8
// for demonstration only; not to be used with FPGA
module async_sram
#(
    parameter DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 2  // number of address bits
   )
   (
    input wire wr_en,
    input wire [ADDR_WIDTH:0] w_addr, r_addr,
    input wire [DATA_WIDTH-1:0] d,
    output wire [DATA_WIDTH-1:0] q
   );
   
   // signal declaration
   reg [DATA_WIDTH-1:0] array_reg [2**ADDR_WIDTH-1:0];

   // body
   // write operation
   always @*
      if (wr_en)
         array_reg[w_addr] <= d;
   // read operation
   assign q = array_reg[r_addr];
endmodule




