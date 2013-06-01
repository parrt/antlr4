// transmitter only
module i2c 
   (
    input wire clk, reset,
    input wire [23:0] din,
    input wire wr_i2c,
    output wire i2c_sclk, i2c_idle, i2c_fail, i2c_done_tick,
    inout wire i2c_sdat
   );

   // symbolic constants
   localparam HALF = 249;  // 10us/20ns/2 = 250 
   localparam QUTR = 125;  // 10us/20ns/4 = 125
   // symbolic state declaration
   localparam [3:0]
      idle      = 4'd1,
      start     = 4'd2,
      scl_begin = 4'd3,
      data1     = 4'd4,
      data2     = 4'd5,
      data3     = 4'd6,
      ack1      = 4'd7,
      ack2      = 4'd8,
      ack3      = 4'd9,
      scl_end   = 4'd10,
      stop      = 4'd11,
      turn      = 4'd12;
      
   // signal declaration
   reg [3:0] state_reg, state_next;
   reg [7:0] c_reg, c_next;
   reg [23:0] data_reg, data_next;
   reg [2:0] bit_reg, bit_next; 
   reg [1:0] byte_reg, byte_next; 
   reg sdat_out, sdat_reg, sclk_out, sclk_reg;
   reg ack_reg, ack_next;
   reg i2c_idle_i, i2c_done_tick_i;

   //body
   //=================================================================
   // output buffer
   //=================================================================
   // buffer for sda and scl lines 
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         sdat_reg <= 1'b1;
         sclk_reg <= 1'b1;
      end
   else
      begin
         sdat_reg <= sdat_out;
         sclk_reg <= sclk_out;
      end 
   // only master drives scl line  
   assign i2c_sclk = sclk_reg;
   // i2c_sdat are with pull-up resistors
   // and becomes high when not driven
   assign i2c_sdat = sdat_reg ? 1'bz : 1'b0;  
   // codac fails to acknowledge properly   
   assign i2c_fail = ack_reg;
   assign i2c_idle = i2c_idle_i;
   assign i2c_done_tick = i2c_done_tick_i;
   //=================================================================
   // fsmd for transmitting three bytes
   //=================================================================
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            c_reg <= 0;
            bit_reg <= 0;
            byte_reg <= 0;
            data_reg <= 0;
            ack_reg <= 1'b1;
         end
      else
         begin
            state_reg <= state_next;
            c_reg <= c_next;
            bit_reg <= bit_next;
            byte_reg <= byte_next;
            data_reg <= data_next;
            ack_reg <= ack_next;
      end 
   // next-state logic
   always @*
   begin
      state_next = state_reg;
      sclk_out = 1'b1;
      sdat_out = 1'b1;
      c_next = c_reg + 1;  // timer counts continuously 
      bit_next = bit_reg;
      byte_next = byte_reg;
      data_next = data_reg;
      ack_next = ack_reg;
      i2c_done_tick_i =1'b0;
      i2c_idle_i =1'b0;
      case (state_reg)
         idle:
            begin 
               i2c_idle_i = 1'b1;
               if (wr_i2c)
                  begin 
                     data_next = din;
                     bit_next = 0; 
                     byte_next = 0; 
                     c_next = 0;
                     state_next = start;
                  end 
            end   
         start:       // start condition 
            begin 
               sdat_out = 1'b0;
               if (c_reg==HALF)
                  begin
                     c_next = 0;
                     state_next = scl_begin;
                  end
            end   
         scl_begin:   // 1st half of scl=0
            begin 
               sclk_out = 1'b0;
               if (c_reg==QUTR) 
                  begin 
                     c_next = 0;
                     state_next = data1;
                  end 
            end   
         data1:
            begin 
               sdat_out = data_reg[23];
               sclk_out = 1'b0;
               if (c_reg==QUTR)
                  begin  
                     c_next = 0;
                     state_next = data2;
                  end 
            end   
         data2:
            begin 
               sdat_out = data_reg[23];
               if (c_reg==HALF)
                  begin
                     c_next = 0;
                     state_next = data3;
                  end   
            end 
         data3:
            begin 
               sdat_out = data_reg[23];
               sclk_out = 1'b0;
               if (c_reg==QUTR)
                  begin
                     c_next = 0;
                     if (bit_reg==7)         // done with 8 bits
                         state_next = ack1;
                     else
                        begin 
                           data_next = {data_reg[22:0], 1'b0};
                           bit_next = bit_reg + 1;
                           state_next = data1;
                        end 
                  end
           end     
         ack1:
            begin 
               sclk_out = 1'b0;
               if (c_reg==QUTR)
                  begin
                     c_next = 0;
                     state_next = ack2;
                  end
            end 
         ack2:
            if (c_reg==HALF)
               begin
                  c_next = 0;
                  state_next = ack3;
                  ack_next =  i2c_sdat;   // read ack from slave 
               end 
         ack3:
            begin 
               sclk_out = 1'b0;
               if (c_reg==QUTR)
                  begin
                     c_next = 0;
                     if (ack_reg)        // slave fails to ack 
                        state_next = scl_end;
                     else    
                        if (byte_reg==2)    // done with 3 bytes
                           state_next = scl_end;   
                        else
                           begin 
                              bit_next = 0;                 
                              byte_next = byte_reg + 1;
                              data_next = {data_reg[22:0], 1'b0};
                              state_next = data1;
                           end
                  end
            end 
         scl_end:                // 2nd half of scl=0
            begin 
               sclk_out = 1'b0;
               sdat_out = 1'b0;
               if (c_reg==QUTR)
                  begin
                     c_next = 0;
                     state_next = stop;
                  end
            end 
         stop:                   // stop condition
            begin 
               sdat_out = 1'b0;
               if (c_reg==HALF)
                  begin
                     c_next = 0;
                     state_next = turn;
                  end 
            end 
         turn:                   // turnaround time 
            if (c_reg==HALF)
               begin
                  state_next = idle;
                  i2c_done_tick_i = 1'b1;
               end
      endcase
   end
endmodule
