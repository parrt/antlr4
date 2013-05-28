// Listing 5.24
module altera_dual_port_ram_true
   #(
    parameter DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 10  // number of address bits
   )
   (
    input wire clk,
    input wire we_a, we_b,
    input wire [ADDR_WIDTH-1:0] addr_a, addr_b,
    input wire [DATA_WIDTH-1:0] d_a, d_b,
    output wire [DATA_WIDTH-1:0] q_a, q_b
   );

   // signal declaration
   reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
   reg [DATA_WIDTH-1:0] data_a_reg, data_b_reg;

   // body
   // port a  
   always @(posedge clk)
   begin
      if (we_a)
      begin
         ram[addr_a] <= d_a;
         data_a_reg <= d_a;
      end
      else    
         data_a_reg <= ram[addr_a];
   end
   // port b  
   always @(posedge clk)
   begin
      if (we_b)
      begin
         ram[addr_b] <= d_b;
         data_b_reg <= d_b;
      end
      else    
         data_b_reg <= ram[addr_b];
   end
   
   // output
   assign q_a = data_a_reg;
   assign q_b = data_b_reg;
endmodule