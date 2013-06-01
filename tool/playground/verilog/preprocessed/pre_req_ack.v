


module req_ack (
    input clk,
    input reset_n,
    input  ack,
    output reg req);


   always @(posedge clk) begin
      if (!reset_n) begin
         req <= 0;
      end else
        if (!req)
         req <= 1;
        else if (ack)
          req <= 0;
      end

endmodule // req_ack




