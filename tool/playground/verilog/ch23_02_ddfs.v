module ddfs 
   #(parameter PW = 26)       // width of phase accumulator
   (
    input wire clk, reset,
    input wire [PW-1:0] fccw, // carrier frequency control word
    input wire [PW-1:0] focw, // frequency offset control word
    input wire [PW-1:0] pha,  // phase offset
    input wire [15:0] env,    // envelop 
    // p2a ram interface
    input wire p2a_we,
    input wire [7:0] p2a_waddr,
    input wire [15:0] p2a_din,
    output wire [15:0] p2a_aout,
    output wire [PW-1:0] p2a_pout
   );

   // signal declaration
   wire [PW-1:0] fcw, p_next, pcw;
   reg [PW-1:0] p_reg;
   wire [7:0] p2a_raddr;
   wire [15:0] amp;
   wire signed [31:0] modu; 

   // body
   // instantiate sin ROM
   altera_ram_lut p2a_ram_unit
      (.clk(clk), .we( p2a_we), .w_addr(p2a_waddr), .d(p2a_din), 
       .r_addr(p2a_raddr), .q(amp));
   // phase register
   always @(posedge clk, posedge reset)
   if (reset)
      p_reg <= 0;
   else
      p_reg <= p_next;
   // frequency modulation
   assign fcw = fccw + focw;
   // phase accumulation 
   assign p_next = p_reg + fcw;
   // phase modulation
   assign pcw = p_reg + pha;   
   // phase to amplitude mapping address
   assign p2a_raddr = pcw[PW-1:PW-8];
   // amplitude modulation 
   // Q16.0 * Q1.15 => modu is Q17.15
   // However the -1 is not used and thus MSB of modu is always 0
   assign modu = $signed(env) * $signed(amp);  // modulated output 
   assign p2a_aout = modu[30:15];
   assign p2a_pout = p_reg;
endmodule   
   
