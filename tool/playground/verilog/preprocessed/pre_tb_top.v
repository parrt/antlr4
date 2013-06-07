

module tb_top;

reg clk, rst;
wire [2:0] data_out;

threebitcounter DUT (.clk(clk), 
                     .rst(rst),
                     .ld(1'b0),
                     .inc(1'b1),
                     .data_in(3'b0),
                     .data_out(data_out));

always #10 clk = ~clk;

initial
  begin
    $monitor ($time,"data_out: ",data_out);
    rst = 1'b1;
    clk = 1'b0;
    @(posedge clk);
    @(negedge clk);
    rst = 1'b0;
#200;
    $finish;
  end
  
endmodule
