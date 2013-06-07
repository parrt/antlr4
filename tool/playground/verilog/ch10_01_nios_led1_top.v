module nios_led1_top 
   (
    input wire clk, 
    input wire [9:0] sw,
    output wire [1:0] ledg
   );

   // body
   // instantiate nios 
   nios_led1 cpu_unit
     (.clk(clk),
      .reset_n(1'b1),
      .in_port_to_the_switch(sw),
      .out_port_from_the_led(ledg)
    );
endmodule

