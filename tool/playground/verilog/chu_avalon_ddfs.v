module chu_avalon_ddfs 
   (
    input wire clk, reset,
    // avalon-MM slave interface
    input wire [8:0] ddfs_address,
    input wire ddfs_chipselect, ddfs_write,
    input wire [31:0] ddfs_writedata,
    // conduit to/from PS2 port
    output wire [15:0] ddfs_data_out
   );

   // signal declaration
   reg [25:0] fccw_reg, focw_reg, pha_reg;
   reg [15:0] env_reg;
   wire wr_en, wr_p2a_ram, wr_fccw, wr_focw, wr_pha, wr_env;

   // body
   //==================================================================
   // instantiate ddfs unit 
   //==================================================================
   ddfs #(.PW(26)) ddfs_unit
      (.clk(clk), .reset(reset), 
       .fccw(fccw_reg), .focw(focw_reg), .pha(pha_reg), .env(env_reg), 
       .p2a_we(wr_p2a_ram), .p2a_waddr(ddfs_address[7:0]),
       .p2a_din(ddfs_writedata[15:0]),
       .p2a_aout(ddfs_data_out), .p2a_pout());
  
   //==================================================================
   // registers and decoding
   //==================================================================
   // registers
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         fccw_reg <= 0;
         focw_reg <= 0;
         pha_reg  <= 0;
         env_reg  <= 16'h7fff;  // almost 1.00
      end
   else
      begin
         if (wr_fccw)
            fccw_reg <= ddfs_writedata[25:0];
         if (wr_focw) 
            focw_reg <= ddfs_writedata[25:0];
         if (wr_pha) 
            pha_reg <= ddfs_writedata[25:0];
         if (wr_env)
            env_reg <= ddfs_writedata[15:0];
      end
   // write decoding
   assign wr_en = ddfs_write & ddfs_chipselect;
   assign wr_fccw = (ddfs_address==9'h000) & wr_en;
   assign wr_focw = (ddfs_address==9'h001) & wr_en;
   assign wr_pha = (ddfs_address==9'h002) & wr_en;
   assign wr_env = (ddfs_address==9'h003) & wr_en;
   assign wr_p2a_ram = ddfs_address[8] & wr_en;
endmodule   
