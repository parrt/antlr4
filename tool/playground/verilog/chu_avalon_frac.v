module chu_avalon_frac 
   (
    input wire clk, reset,
    // Avalon-MM slave interface
    input wire [1:0] frac_address,
    input wire frac_chipselect, frac_write,
    input wire [31:0] frac_writedata,
    output wire [31:0] frac_readdata
   );

   // signal declaration
   wire frac_start, frac_ready;
   reg [31:0] cx_reg, cy_reg;
   reg [15:0] max_it_reg;
   wire [15:0] iter_out;
   wire wr_en, wr_cx, wr_cy, wr_max;

   // body
   //==================================================================
   // instantiate fractal unit 
   //==================================================================
   frac_engine frac_unit
       (.clk(clk), .reset(reset), .iter(iter_out),
        .frac_start(frac_start), .cx(cx_reg), .cy(cy_reg),
        .max_it(max_it_reg), .frac_ready(frac_ready), 
        .frac_done_tick());
   
   //==================================================================
   // registers, decoding, and multiplexing 
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         cx_reg <= 0;
         cy_reg <= 0;
         max_it_reg <= 0;
      end   
   else
      begin
         if (wr_cx)
            cx_reg <= frac_writedata;
         if (wr_cy)
            cy_reg <= frac_writedata;
         if (wr_max)
            max_it_reg <= frac_writedata[15:0];
      end 
   // write decoding
   assign wr_en = frac_write & frac_chipselect;
   assign wr_cx = (frac_address==2'b00) & wr_en;
   assign wr_cy = (frac_address==2'b01) & wr_en;
   assign wr_max = (frac_address==2'b10) & wr_en;
   assign frac_start = (frac_address==2'b11) & wr_en;
   // read data
   assign frac_readdata = {15'b0, frac_ready, iter_out};
endmodule