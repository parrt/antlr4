module chu_avalon_gcd 
   (
    input wire clk, reset,
    // Avalon-MM slave interface
    input wire [2:0] gcd_address,
    input wire gcd_chipselect, gcd_write,
    input wire [31:0] gcd_writedata,
    output wire [31:0] gcd_readdata
   );

   // symbolic state declaration
   localparam [1:0]
      idle  = 2'b01,
      count = 2'b10;

   // signal declaration
   reg [1:0] state_reg, state_next;
   wire gcd_start, gcd_ready, gcd_done_tick;
   reg [31:0] a_in_reg, b_in_reg;
   wire [31:0] r_out;
   wire wr_en, wr_a, wr_b;
   reg [15:0] c_reg, c_next;
   
   //body
   //==================================================================
   // instantiate gcd unit
   //==================================================================
   gcd_engine gcd_unit
      (.clk(clk), .reset(reset), .start(gcd_start),
       .a_in(a_in_reg), .b_in(b_in_reg), .r(r_out),  
       .gcd_done_tick(gcd_done_tick), .ready(gcd_ready));

   //==================================================================
   // registers, decoding, and multiplexing 
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         a_in_reg <= 0;
         b_in_reg <= 0;
      end   
   else
      begin
         if (wr_a)
            a_in_reg <= gcd_writedata;
         if (wr_b)
            b_in_reg <= gcd_writedata;
      end
   // write decoding
   assign wr_en = gcd_write & gcd_chipselect;
   assign wr_a = (gcd_address==3'b000) &  wr_en;
   assign wr_b = (gcd_address==3'b001) &  wr_en;
   assign gcd_start = (gcd_address==3'b010) &  wr_en;
   // read multiplexing
   assign gcd_readdata = 
            (gcd_address==3'b100) ?  r_out : {gcd_ready, 15'b0, c_reg};

   //==================================================================
   // auxiliary counter to measure the  cycles in execution
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            c_reg <= 0;
         end   
      else 
         begin 
            state_reg <= state_next;
            c_reg <= c_next;
         end   
   // next-state logic 
   always @*
   begin
      c_next = c_reg;
      state_next = state_reg;
      case (state_reg)
         idle:
            if (gcd_start)
               begin 
                  c_next = 1;
                  state_next = count;
               end   
         count:
            if (gcd_done_tick)
               state_next = idle;
            else
               c_next = c_reg + 1;
      endcase
   end               
endmodule