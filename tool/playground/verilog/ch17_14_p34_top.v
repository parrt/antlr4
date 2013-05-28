module top_p34 
   (
    input wire clk,
    // switch and LED
    input wire [9:0] sw,
    input wire [3:0] key,
    output wire [7:0] ledg,
    output wire [9:0] ledr, 
    output wire [6:0] hex3, hex2, hex1, hex0,
    // PS2
    inout ps2c, ps2d,
    // VGA
    output wire vsync, hsync,
    output wire [11:0] rgb,
    // audio codec
    output wire m_clk, b_clk, dac_lr_clk, adc_lr_clk,
    output wire dacdat,
    input wire adcdat,
    output wire i2c_sclk,
    inout wire i2c_sdat,
    // SD card
    output wire sd_clk, sd_di, sd_cs,
    input wire  sd_do,
    // SRAM
    output wire [17:0] sram_addr,
    inout wire [15:0] sram_dq,
    output wire sram_ce_n, sram_oe_n, sram_we_n,
    output wire sram_lb_n, sram_ub_n,
    // SDRAM 
    output wire dram_clk, 
    output wire dram_cs_n, dram_cke, dram_ldqm, dram_udqm,
    output wire dram_cas_n, dram_ras_n, dram_we_n,
    output wire [11:0] dram_addr,
    output wire dram_ba_0, dram_ba_1,
    inout wire [15:0] dram_dq
   );

   // signal declaration
   wire [18:0] led;
   wire [31:0] sseg;
   wire [15:0] ddfs_data;   
   wire dac_load_tick;   
   
   // body
   // instantiate nios 
   nios_p34 cpu_unit
     (.clk_50M(clk),
      .clk_sys(), 
      .clk_sdram(dram_clk),
      .reset_n(key[3]),
      // switch and LED
      .in_port_to_the_btn({1'b0,key[2:0]}),
      .in_port_to_the_switch(sw),
      .out_port_from_the_led(led),
      .out_port_from_the_sseg(sseg),
      // PS2
      .ps2c_to_and_from_the_ps2(ps2c),
      .ps2d_to_and_from_the_ps2(ps2d),
      //  VGA monitor  
      .hsync_from_the_vram(hsync),
      .vsync_from_the_vram(vsync),
      .rgb_from_the_vram(rgb),
      // VGA SRAM
      .sram_addr_from_the_vram(sram_addr),
      .sram_ce_n_from_the_vram(sram_ce_n),
      .sram_dq_to_and_from_the_vram(sram_dq),
      .sram_lb_n_from_the_vram(sram_lb_n),
      .sram_oe_n_from_the_vram(sram_oe_n),
      .sram_ub_n_from_the_vram(sram_ub_n),
      .sram_we_n_from_the_vram(sram_we_n),
      // audio codec
      .b_clk_from_the_audio(b_clk),
      .m_clk_from_the_audio(m_clk),
      .dac_lr_clk_from_the_audio(dac_lr_clk),
      .adc_lr_clk_from_the_audio(adc_lr_clk),
      .dacdat_from_the_audio(dacdat),
      .adcdat_to_the_audio(adcdat),
      .i2c_sclk_from_the_audio(i2c_sclk),
      .i2c_sdat_to_and_from_the_audio(i2c_sdat),
      .codec_adc_data_out_from_the_audio(),
      .codec_adc_rd_to_the_audio(dac_load_tick),
      .codec_dac_data_in_to_the_audio({ddfs_data, ddfs_data}),
      .codec_dac_wr_to_the_audio(dac_load_tick),
      .codec_sample_tick_from_the_audio(dac_load_tick),
      // SD card
      .sd_clk_from_the_sdc(sd_clk),
      .sd_do_to_the_sdc(sd_do),
      .sd_di_from_the_sdc(sd_di),        
      .sd_cs_from_the_sdc(sd_cs),        
      // DDFS
      .ddfs_data_out_from_the_d_engine(ddfs_data),
       // SDRAM
      .zs_addr_from_the_sdram(dram_addr),
      .zs_ba_from_the_sdram({dram_ba_1, dram_ba_0}),   
      .zs_cas_n_from_the_sdram(dram_cas_n),
      .zs_cke_from_the_sdram(dram_cke),
      .zs_cs_n_from_the_sdram(dram_cs_n),
      .zs_dq_to_and_from_the_sdram(dram_dq),
      .zs_dqm_from_the_sdram({dram_udqm, dram_ldqm}),
      .zs_ras_n_from_the_sdram(dram_ras_n),
      .zs_we_n_from_the_sdram(dram_we_n) 
    );   
    // output assignment
    assign hex3 = sseg[30:24];       
    assign hex2 = sseg[22:16];       
    assign hex1 = sseg[14:8];       
    assign hex0 = sseg[6:0];       
    assign ledr = led[17:8];
    assign ledg = led[7:0];      
endmodule