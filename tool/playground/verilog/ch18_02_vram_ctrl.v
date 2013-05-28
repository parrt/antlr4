module vram_ctrl 
   (
    input wire clk, reset,
    // from video sync
    input  wire [9:0] pixel_x, pixel_y,
    input wire p_tick,
    // memory interface to vga read 
    output wire [7:0] vga_rd_data,
    // memory interface to cpu
    input wire cpu_mem_wr, cpu_mem_rd,
    input wire [18:0] cpu_addr,
    input wire [7:0] cpu_wr_data,
    output wire [7:0] cpu_rd_data,
    // to/from SRAM
    output wire [17:0] sram_addr,
    inout [15:0] sram_dq,
    output sram_ce_n, sram_oe_n, sram_we_n,
    output sram_lb_n, sram_ub_n
   );

   // symbolic state declaration
   localparam [2:0]
      idle  = 3'b000,
      waitr = 3'b001,
      rd =    3'b010,
      fetch = 3'b011,
      waitw = 3'b100,
      wr =    3'b101;

   // signal declaration
   reg [2:0] state_reg, state_next;
   reg [7:0] vga_rd_data_reg;
   reg [18:0] cpu_addr_reg, cpu_addr_next;
   wire [18:0] mem_addr;
   wire [18:0] y_offset, vga_addr;
   reg [7:0] cpu_rd_data_reg, cpu_rd_data_next;
   reg [7:0] wr_data_reg, wr_data_next;
   reg we_n_reg;
   wire we_n_next;
   wire [7:0] byte_from_sram;
   wire vga_cycle;
  
   // body
   // p_tick asserted every 2 clock cycles; 
   assign vga_cycle = p_tick;     
   //==================================================================
   // VGA port SRAM read operation 
   //==================================================================
   // VGA port read SRAM continuousely 
   // read registers 
   always @(posedge clk)
      if (vga_cycle) 
         vga_rd_data_reg <= byte_from_sram;
   // VGA port address offset = 640*y + x = 512*y + 128*y + x
   assign y_offset = {1'b0, pixel_y[8:0], 9'b0} + 
                     {3'b0, pixel_y[8:0], 7'b0};
   assign vga_addr = y_offset + pixel_x;
   assign vga_rd_data = vga_rd_data_reg;
   //==================================================================
   // CPU port SRAM read/write operation 
   //==================================================================
   assign cpu_rd_data= cpu_rd_data_reg;
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            cpu_addr_reg <= 0;
            wr_data_reg <= 0;
            cpu_rd_data_reg <= 0;
         end
      else
         begin
            state_reg <= state_next;
            cpu_addr_reg <= cpu_addr_next;
            wr_data_reg <= wr_data_next;
            cpu_rd_data_reg <= cpu_rd_data_next;
            we_n_reg <= we_n_next;
         end
   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      cpu_addr_next = cpu_addr_reg;
      wr_data_next = wr_data_reg;
      cpu_rd_data_next = cpu_rd_data_reg;
      case (state_reg)
         idle:
            if (cpu_mem_wr)
               begin
                  cpu_addr_next = cpu_addr;
                  wr_data_next = cpu_wr_data;
                  if (vga_cycle)
                     state_next = wr;
                  else 
                     state_next = waitw;
               end 
            else if (cpu_mem_rd) 
               if (vga_cycle)  
                  state_next = rd;
               else         
                  begin
                     cpu_rd_data_next = byte_from_sram;
                     state_next = waitr;
                  end    
         rd:
            begin 
               cpu_rd_data_next = byte_from_sram;
               state_next = fetch;
            end
         waitr:
            state_next = fetch;
         fetch:
            state_next = idle;
         waitw:
            state_next = wr;
         wr:
            state_next = idle;
      endcase;
   end   
   // look-ahead output
   assign we_n_next = (state_next==wr) ? 1'b0 : 1'b1; 
   //==================================================================
   // SRAM interface signals 
   //==================================================================
   // configure SRAM as 512K-by-8  
   assign mem_addr = vga_cycle   ? vga_addr :     
                     (~we_n_reg) ? cpu_addr_reg : 
                                   cpu_addr;                           
   assign sram_addr = mem_addr[18:1];
   assign sram_lb_n = (~mem_addr[0]) ? 1'b0 : 1'b1; 
   assign sram_ub_n = (mem_addr[0])  ? 1'b0 : 1'b1; 
   assign sram_ce_n = 1'b0;
   assign sram_oe_n = 1'b0;
   assign sram_we_n = we_n_reg;
   assign sram_dq = (~we_n_reg) ? {wr_data_reg, wr_data_reg} : 16'bz;
   // LSB control lb ub
   assign byte_from_sram = mem_addr[0] ? sram_dq[15:8] : sram_dq[7:0];
endmodule