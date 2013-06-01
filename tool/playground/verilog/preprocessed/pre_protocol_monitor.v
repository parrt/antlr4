

module protocol_monitor(
   input clk,
   input reset_n,
   input req,
   input ack);

  wire [`OVL_FIRE_WIDTH-1:0] fire;

  ovl_handshake
    check_ack
    (
       // Unique ports on ovl_handshake
     .req(req), .ack(ack),

       // Common ports on all OVL
     .clock(clk), .reset(reset_n), .enable(1'b1), .fire(fire));

 endmodule


