
module req_ack_tester (input clk,input reset_n, input req, output reg ack);

   reg   req_flag;
   reg [1:0] cnt;


   always @(negedge clk)
      if (!reset_n) begin
         req_flag = 0;
         ack = 0;
         cnt = 0;
      end
      else if (req)
         if (req_flag)
            if (cnt == 0) begin
               ack = 1;
               req_flag = 0;
               @(negedge clk);
               ack = 0;
             end // cnt == 0
            else //cnt != 0
               cnt = cnt - 1;
         else begin //req_flag == 0
            req_flag = 1;
            cnt = $random;
         end // else: !if(cnt == 0)
endmodule // arb_tb
