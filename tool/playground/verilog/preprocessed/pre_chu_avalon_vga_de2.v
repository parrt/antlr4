module chu_avalon_vga_de2
   (
    input wire clk, reset,
    // Avalon MM interface
    input wire [19:0] vga_address,
    input wire vga_chipselect, vga_write, vga_read,
    input wire [31:0] vga_writedata,
    output wire [31:0] vga_readdata,
    // conduit (to VGA monitor)
    output wire vsync, hsync,
    /
