module nios_div2_top 
   (
    input wire clk, 
    output wire [7:0] ledg,
    output wire [6:0] hex3, hex2, hex1, hex0,
    output wire [17:0] sram_addr,
    inout wire [15:0] sram_dq,
    output wire sram_ce_n, sram_oe_n, sram_we_n,
    output wire sram_lb_n, sram_ub_n
   );

   // signal declaration
   wire [31:0] sseg;
   
   // body
   // instantiate nios 
   nios_div2  cpu_unit
     (.clk(clk),
      .reset_n(1'b1),
      .div_led_from_the_div32(ledg),
      .out_port_from_the_sseg(sseg),
      .sram_addr_from_the_sram(sram_addr),
      .sram_ce_n_from_the_sram(sram_ce_n),
      .sram_dq_to_and_from_the_sram(sram_dq),
      .sram_lb_n_from_the_sram(sram_lb_n),
      .sram_oe_n_from_the_sram(sram_oe_n),
      .sram_ub_n_from_the_sram(sram_ub_n),
      .sram_we_n_from_the_sram(sram_we_n)
    );   
    // output assignment
    assign hex3 = sseg[30:24];       
    assign hex2 = sseg[22:16];       
    assign hex1 = sseg[14:8];       
    assign hex0 = sseg[6:0];   
endmodule

