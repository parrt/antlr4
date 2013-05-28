module adc_dac 
   (
    input wire clk, reset,
    input wire [31:0] dac_data_in,
    output wire [31:0] adc_data_out,
    output wire  m_clk, b_clk, dac_lr_clk, adc_lr_clk,
    output wire dacdat,
    input wire adcdat,
    output wire load_done_tick
   );

   // symbolic constants
   localparam M_DVSR = 2;
   localparam B_DVSR = 3;
   localparam LR_DVSR = 5;

   // signal declaration
   reg [M_DVSR-1:0] m_reg;
   wire [M_DVSR-1:0] m_next; 
   reg [B_DVSR-1:0] b_reg;
   wire [B_DVSR-1:0] b_next; 
   reg [LR_DVSR-1:0] lr_reg;
   wire [LR_DVSR-1:0] lr_next; 
   reg [31:0] dac_buf_reg, adc_buf_reg;
   wire [31:0] dac_buf_next, adc_buf_next; 
   reg lr_delayed_reg, b_delayed_reg;
   wire m_12_5m_tick, load_tick, b_neg_tick, b_pos_tick;

   // body
   //=================================================================
   // clock signals for codec digital audio interface
   //=================================================================
   // registers
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         m_reg <= 0;
         b_reg <= 0;
         lr_reg <= 0;
         dac_buf_reg <= 0;
         adc_buf_reg <= 0;
         b_delayed_reg <= 1'b0;
         lr_delayed_reg <= 1'b0;
      end   
   else
      begin
         m_reg <= m_next;
         b_reg <= b_next;
         lr_reg <= lr_next;
         dac_buf_reg <= dac_buf_next;
         adc_buf_reg <= adc_buf_next;
         b_delayed_reg <= b_reg[B_DVSR-1];
         lr_delayed_reg <= lr_reg[LR_DVSR-1];
      end
   // codec 12.5 MHz m_clk (master clock)
   // ideally should be 12.288 MHz
   assign m_next = m_reg + 1;  // mod-4 counter
   assign m_clk = m_reg[M_DVSR-1];
   assign m_12_5m_tick = (m_reg==0) ? 1'b1 : 1'b0;
   // b_clk (m_clk / 8 = 32*48 KHz )
   assign b_next = m_12_5m_tick ? b_reg + 1 : b_reg;  // mod-8 counter
   assign b_clk = b_reg[B_DVSR-1];
   // neg edge of b_clk
   assign b_neg_tick = b_delayed_reg & ~b_reg[B_DVSR-1];
   // pos edge of b_clk
   assign b_pos_tick = ~b_delayed_reg & b_reg[B_DVSR-1];
   // adc_/dac_lr_clk (dac_lr_clk / 32 = 48 KHz )
   assign lr_next = b_neg_tick ? lr_reg + 1 : lr_reg; // mod-32 counter
   assign dac_lr_clk = lr_reg[LR_DVSR-1];
   assign adc_lr_clk = lr_reg[LR_DVSR-1];
   // load DAC tick at the 0-to-1 transition of dac_lr_clk
   assign load_tick = ~lr_delayed_reg & lr_reg[LR_DVSR-1];
   assign load_done_tick = load_tick;
   //=================================================================
   // DAC buffer to shift out data
   // data shifted out at b_clk 1-to-0 edge
   //=================================================================
   assign dac_buf_next = load_tick  ? dac_data_in :
                         b_neg_tick ? {dac_buf_reg[30:0], 1'b0} :
                                      dac_buf_reg;
   assign dacdat = dac_buf_reg[31];
   //=================================================================
   // ADC buffer to shift in data
   //    data shifted out at the b_clk 1-to-0 edge from ADC
   //    use 0-to-1 edge to latch in ADC data 
   //=================================================================
   assign adc_buf_next = b_pos_tick ? {adc_buf_reg[30:0], adcdat} :
                                      adc_buf_reg;
   assign adc_data_out = adc_buf_reg;  
endmodule