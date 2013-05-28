module palette_de2
   (
    input wire [7:0] color_in,
    output wire [29:0] color_out
   );

   wire [9:0] r10, g10, b10; 
   // body
   // 3-bit red to 10-bit red, 3-bit green to 10-bit green 
   // 2-bit blue to 10-bit blue 
   assign r10 = {{3{color_in[7:5]}}, color_in[7]};
   assign g10 = {{3{color_in[4:2]}}, color_in[4]};
   assign b10 = {5{color_in[1:0]}};
   assign color_out = {r10, g10, b10};
endmodule
                       