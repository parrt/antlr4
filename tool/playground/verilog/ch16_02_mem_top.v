module mem_top 
   (
    input wire clk, 
    // to/from SRAM
    output wire [17:0] sram_addr,
    output wire sram_ce_n, sram_oe_n, sram_we_n,
    output wire sram_lb_n, sram_ub_n,
    inout wire [15:0] sram_dq,
    // to/from SDRAM side
    output wire dram_clk, 
    output wire dram_cs_n, dram_cke, dram_ldqm, dram_udqm,
    output wire dram_cas_n, dram_ras_n, dram_we_n,
    output wire [11:0] dram_addr,
    output wire dram_ba_0, dram_ba_1,
    inout wire [15:0] dram_dq
   );

   // body
   // instantiate nios 
   nios_ram cpu_unit
     (.clk_50M(clk),
      .clk_sys(), 
      .clk_sdram(dram_clk),
      .reset_n(1'b1),
      // SRAM 
      .sram_addr_from_the_sram(sram_addr),
      .sram_ce_n_from_the_sram(sram_ce_n),
      .sram_dq_to_and_from_the_sram(sram_dq),
      .sram_lb_n_from_the_sram(sram_lb_n),
      .sram_oe_n_from_the_sram(sram_oe_n),
      .sram_ub_n_from_the_sram(sram_ub_n),
      .sram_we_n_from_the_sram(sram_we_n),
      // SDRAM
      .zs_addr_from_the_sdram(dram_addr),
      .zs_ba_from_the_sdram({dram_ba_1,dram_ba_0}),   
      .zs_cas_n_from_the_sdram(dram_cas_n),
      .zs_cke_from_the_sdram(dram_cke),
      .zs_cs_n_from_the_sdram(dram_cs_n),
      .zs_dq_to_and_from_the_sdram(dram_dq),
      .zs_dqm_from_the_sdram({dram_udqm,dram_ldqm}),
      .zs_ras_n_from_the_sdram(dram_ras_n),
      .zs_we_n_from_the_sdram(dram_we_n) 
    );   
endmodule
