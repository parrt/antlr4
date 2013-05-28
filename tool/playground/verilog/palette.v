module palette 
   (
    input wire [7:0] color_in,
    output wire [11:0] color_out
   );

   // body
   // 3-bit red to 4-bit red, 3-bit green to 4-bit green 
   // 2-bit blue to 4-bit blue
   assign color_out = 
      {color_in[7:5], color_in[5],     
       color_in[4:2], color_in[2],     
       color_in[1:0], color_in[0], color_in[0]}; 
endmodule
                       