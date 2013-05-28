
module frac_engine 
   #(
    parameter W = 32,   // width (# bits) of Qm.f format
    parameter M= 4      // # of bits in m
   )
   (
    input wire clk, reset,
    input wire frac_start,
    input wire [W-1:0] cx, cy, 
    input wire [15:0] max_it,
    output wire [15:0] iter,
    output wire frac_ready, frac_done_tick
   );

   // constant declaration
   localparam F = W - M; // # of bits in fraction
   
   // symbolic state declaration
   localparam [1:0]
      idle = 2'b01,
      op   = 2'b10;

   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [15:0] it_reg, it_next;
   wire signed [2*W-1:0] xx_raw, yy_raw, xy_raw;
   wire signed [W-1:0] xx, yy, xy2;
   reg signed [W-1:0] x_reg, x_next, y_reg, y_next; 
   reg signed [W-1:0] cx_reg, cx_next, cy_reg, cy_next; 
   wire escape;
   reg frac_ready_i, frac_done;
   
   // body
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            it_reg <= 0;
            x_reg <= 0;
            y_reg <= 0;
            cx_reg <= 0;
            cy_reg <= 0;
         end    
      else
         begin
            state_reg <= state_next;
            it_reg <= it_next;
            x_reg <= x_next;
            y_reg <= y_next;
            cx_reg <= cx_next;
            cy_reg <= cy_next;
         end
   
   // fixed-point multiplications 
   assign xx_raw = x_reg * x_reg;         // in Q2m.2f  
   assign xx = xx_raw[(2*W-1)-M:F];       // back to Qm.f  
   assign yy_raw = y_reg * y_reg;         // in Q2m.2f 
   assign yy = yy_raw[(2*W-1)-M:F];       // back to Qm.f 
   assign xy_raw  = x_reg * y_reg;        // xy in Q2m.2f
   assign xy2 = xy_raw[(2*W-1)-M-1:F-1];  // 2xy in Qm.f 
   // escape condition 
   assign escape = (xx+yy > 32'h40000000); 
   
   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      it_next = it_reg;
      x_next = x_reg;
      y_next = y_reg;
      cx_next = cx_reg;
      cy_next = cy_reg;
      frac_ready_i = 1'b0;
      frac_done = 1'b0;
      case (state_reg)
         idle:
            begin
               frac_ready_i = 1'b1;
               if (frac_start)
                  begin 
                     x_next = cx;
                     y_next = cy;
                     cx_next = cx;
                     cy_next = cy;
                     it_next = 0;
                     state_next = op;
                  end   
            end
         op:
            begin 
               x_next = xx - yy + cx_reg;
               y_next = xy2 + cy_reg; 
               it_next = it_reg +  1;
               if (escape | (it_next==max_it))  
                  begin 
                     state_next = idle;
                     frac_done = 1'b1;
                  end   
            end
      endcase
   end
   
   // output assignment
   assign iter = it_reg;
   assign frac_done_tick = frac_done;
   assign frac_ready = frac_ready_i;
endmodule