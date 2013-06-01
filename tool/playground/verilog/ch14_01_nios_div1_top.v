module nios_div1_top 
   (
    input wire clk, 
    output wire [7:0] ledg,
    output wire [6:0] hex3, hex2, hex1, hex0,
    output wire [17:0] sram_addr,
    inout [15:0] sram_dq,
    output sram_ce_n, sram_oe_n, sram_we_n,
    output sram_lb_n, sram_ub_n
   );

   // signal declaration
   wire [31:0] dvnd, dvsr, quo, rmd;
   wire [31:0] sseg;
   wire start, ready, done_tick;
   
   // body
   // instantiate nios 
   nios_div1  cpu_unit
     (.clk(clk),
      .reset_n(1'b1),
      .out_port_from_the_sseg(sseg),
      .out_port_from_the_start(start),
      .out_port_from_the_dvnd(dvnd),
      .out_port_from_the_dvsr(dvsr),
      .in_port_to_the_quo(quo),
      .in_port_to_the_rmd(rmd),
      .in_port_to_the_ready(ready),
      .in_port_to_the_done_tick(done_tick),
      .sram_addr_from_the_sram(sram_addr),
      .sram_ce_n_from_the_sram(sram_ce_n),
      .sram_dq_to_and_from_the_sram(sram_dq),
      .sram_lb_n_from_the_sram(sram_lb_n),
      .sram_oe_n_from_the_sram(sram_oe_n),
      .sram_ub_n_from_the_sram(sram_ub_n),
      .sram_we_n_from_the_sram(sram_we_n)
    );   
   // instantiate division circuit
   div #(.W(32), .CBIT(6)) d_unit
     (.clk(clk), .reset(1'b0), .start(start),
      .dvsr(dvsr), .dvnd(dvnd), .quo(quo), .rmd(rmd),
      .ready(ready), .done_tick(done_tick));
    // output assignment
    assign hex3 = sseg[30:24];       
    assign hex2 = sseg[22:16];       
    assign hex1 = sseg[14:8];       
    assign hex0 = sseg[6:0];   
    assign ledg = rmd[7:0];       
endmodule

