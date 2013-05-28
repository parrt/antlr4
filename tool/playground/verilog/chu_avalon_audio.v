module chu_avalon_audio 
   #(parameter FIFO_SIZE = 3) // 2^FIFO_SIZE words 
   (
    input wire clk, reset,
    // Avalon MM interface
    input wire [1:0] audio_address,
    input wire audio_chipselect, audio_write, audio_read,
    input wire [31:0] audio_writedata,
    output wire [31:0] audio_readdata,
    // conduit interface (to codec chip)
    output wire  m_clk, b_clk, dac_lr_clk, adc_lr_clk,
    output wire dacdat,
    input wire adcdat,
    output wire i2c_sclk,
    inout wire i2c_sdat,
    // conduit interface (to other systems in FPGA)
    input wire codec_adc_rd, codec_dac_wr,
    output wire codec_sample_tick, 
    input wire [31:0] codec_dac_data_in,
    output wire [31:0] codec_adc_data_out
   );

   // signal declaration
   reg[1:0] dbus_sel_reg;
   wire wr_en, wr_i2c, i2c_idle, wr_sel;
   wire [31:0] dac_fifo_in, adc_fifo_out;
   wire wr_dac_fifo, cpu_wr_dac_fifo, rd_adc_fifo, cpu_rd_adc_fifo;
   wire adc_fifo_empty, dac_fifo_full;  

   // body
   //==================================================================
   // instantiate codec controller   
   //==================================================================
   codec_top #(.FIFO_SIZE(FIFO_SIZE)) codec_unit
      (.clk(clk), .reset(reset), 
       .i2c_sclk(i2c_sclk), .i2c_sdat(i2c_sdat),      
       .m_clk(m_clk), .b_clk(b_clk), .dac_lr_clk(dac_lr_clk), 
       .adc_lr_clk(adc_lr_clk), .dacdat(dacdat), .adcdat(adcdat), 
       .wr_i2c(wr_i2c), .i2c_idle(i2c_idle),
       .i2c_packet(audio_writedata[23:0]),
       .rd_adc_fifo(rd_adc_fifo), .adc_fifo_empty(adc_fifo_empty),
       .adc_fifo_out(adc_fifo_out), .wr_dac_fifo(wr_dac_fifo),
       .dac_fifo_full(dac_fifo_full), .dac_fifo_in(dac_fifo_in), 
       .sample_tick(codec_sample_tick));

   //==================================================================
   // registers, write decoding, and read multiplexing 
   //==================================================================
   // data stream selection register 
   always @(posedge clk, posedge reset)
   if (reset)
      dbus_sel_reg <= 2'b0;
   else
     if (wr_sel) 
        dbus_sel_reg <= audio_writedata[1:0];
        
   // write decoding
   assign wr_en = audio_write & audio_chipselect;
   assign wr_i2c = (audio_address==2'b00) & wr_en;
   assign wr_sel = (audio_address==2'b01) & wr_en;
   assign cpu_wr_dac_fifo = (audio_address==2'b10) & wr_en;
   assign cpu_rd_adc_fifo = (audio_address==2'b11) & audio_read & 
                            audio_chipselect;
   // read multiplexing   
   assign audio_readdata = 
              (audio_address==2'b11) ? 
              adc_fifo_out :
              {29'b0, adc_fifo_empty, dac_fifo_full, i2c_idle};

   //==================================================================
   // data stream routing & control
   //==================================================================
   assign wr_dac_fifo = 
            dbus_sel_reg[0] ? codec_dac_wr : cpu_wr_dac_fifo;
   assign dac_fifo_in =
            dbus_sel_reg[0] ? codec_dac_data_in : audio_writedata;
   assign rd_adc_fifo =
            dbus_sel_reg[1] ? codec_adc_rd : cpu_rd_adc_fifo;
   assign codec_adc_data_out = adc_fifo_out;
endmodule