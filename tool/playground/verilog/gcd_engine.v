module gcd_engine 
   (
    input wire clk, reset,
    input wire start,
    input wire [31:0] a_in, b_in,
    output wire gcd_done_tick, ready,
    output wire [31:0] r
   );

   // symbolic state declaration
   localparam [1:0]
      idle = 2'b01,
      op   = 2'b10;

   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [31:0] a_reg, a_next, b_reg, b_next;
   reg [4:0] n_reg, n_next;
   reg gcd_done;

   // body
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            a_reg <= 0;
            b_reg <= 0;
            n_reg <= 0;
    end  
      else
         begin 
            state_reg <= state_next;
            a_reg <= a_next;
            b_reg <= b_next;
            n_reg <= n_next;
         end 
   // next-state logic & data path functional units
   always @*
   begin
      a_next = a_reg;
      b_next = b_reg;
      n_next = n_reg;
      state_next = state_reg;
      gcd_done = 1'b0;
      case (state_reg)
         idle: 
            if (start)
               begin 
                  a_next = a_in;
                  b_next = b_in;
                  n_next = 0;
                  state_next = op;
               end   
         op:
            if (a_reg==b_reg) 
               begin  
                  state_next = idle;
                  gcd_done = 1'b1;
                  a_next = a_reg << n_reg;
               end   
            else
               if (~a_reg[0])                 // a_reg even
                  begin
                     a_next = {1'b0, a_reg[31:1]};
                     if (~b_reg[0])           // both even
                        begin
                           b_next = {1'b0, b_reg[31:1]};
                           n_next = n_reg + 1;
                        end 
                  end   
               else                           // a_reg odd
                  if (~b_reg[0])              // b_reg even
                     b_next = {1'b0, b_reg[31:1]};
                  else                        // both odd
                     if (a_reg > b_reg) 
                        a_next = a_reg - b_reg; 
                     else
                        b_next = b_reg - a_reg;
      endcase;
   end 
   //output
   assign ready = (state_reg==idle);
   assign r = a_reg;
   assign gcd_done_tick = gcd_done;
endmodule


