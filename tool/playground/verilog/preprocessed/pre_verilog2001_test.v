

module Nbit_adder (co, sum, a, b, ci);

parameter SIZE = 4; 
output [SIZE-1:0] sum; 
output co; 
input [SIZE-1:0] a, b; 
input ci; 
wire [SIZE:0] c; 

genvar i;   
assign c[0] = ci;

assign co = c[SIZE];  

generate
 for(i=0; i<SIZE; i=i+1)
  begin:addbit
   wire n1,n2,n3; //internal nets
   xor g1 (n1 ,a[i] ,b[i]);
   xor g2 (sum[i] ,n1 ,c[i]);
   and g3 (n2 , a[i] ,b[i]);
   and g4 (n3 , n1 ,c[i]); 
   or g5 (c[i+1] ,n2 ,n3);
  end 
endgenerate 

endmodule 



module Nbit_adder2 (co, sum, a, b, ci);

parameter SIZE = 4;
output [SIZE-1:0] sum;
output co;
input [SIZE-1:0] a, b;
input ci;
wire [SIZE:0] c; 

genvar i;   
assign c[0] = ci;

assign co = c[SIZE];  

generate
 for(i=0; i<SIZE; i=i+1)
  begin:addbit
   wire n1,n2,n3; //internal nets
   xor g1 (n1 ,a[i] ,b[i]);
   xor g2 (sum[i] ,n1 ,c[i]); 
   and g3 (n2 , a[i] ,b[i]);
   and g4 (n3 , n1 ,c[i]); 
   or g5 (c[i+1] ,n2 ,n3);
  end 
endgenerate

endmodule 



module ram (address, write, chip_select, data);

parameter WIDTH = 8;
parameter SIZE = 256;
localparam ADDRESS_SIZE = SIZE;
input [ADDRESS_SIZE-1:0] address;
input write, chip_select;
inout [WIDTH-1:0] data;

reg [WIDTH-1:0] ram_data [0:SIZE-1];

//define the clogb2 constant function

function integer clogb2;
  input depth;
  integer i;
  begin
   clogb2 = 1;
   for (i = 0; 2**i < depth; i = i + 1)
      clogb2 = i + 1; 
  end
endfunction

endmodule

module selects_and_arrays;

reg [63:0] word; 
reg [3:0] byte_num; //a value from 0 to 7 
wire [7:0] byteN = word[byte_num*8 +: 8];

parameter address = 5;
//1-dimensional array of 8-bit reg variables 
//(allowed in Verilog-1995 and Verilog-2000) 
reg [7:0] array1 [0:255]; 
wire [7:0] out1 = array1[address]; 

parameter addr1=1 , addr2 = 2, addr3 =3;
//3-dimensional array of 8-bit wire nets 
//(new for Verilog-2000) 
wire [7:0] array3 [0:255][0:255][0:15];
wire [7:0] out3 = array3[addr1][addr2][addr3];


//2-dimensional array of 32-bit reg variables 
reg [31:0] array2 [0:255][0:15]; 
wire [7:0] out2 = array2[100][7][31:24];

signed_test s1 (8'sH08);

endmodule


module signed_test (i);
	input signed [7:0] i;

reg signed [63:0] data;
wire signed [7:0] vector;
input signed [31:0] a;

endmodule

module automatic_tf;

function automatic [63:0] factorial;
input [31:0] n; 
if (n == 1)
	factorial = 1; 
else
	factorial = n * factorial(n-1); 
endfunction


task automatic auto_task;
	input call;
	if (call) 
		auto_task(0); // automatic tasks are re-enterant
endtask


endmodule


module new_event_control;
	output y;
	reg y;
	input a,b,sel;
	
always @* //combinational logic sensitivity
	if (sel)
		y = a;
	else
		y = b;

endmodule

module new_parameter;

parameter [2:0]    // new width
	IDLE = 3'd0,
	READ = 3'd1,
	LOAD = 3'd2,
	SYNC = 3'd3,
	ERROR = 3'd4;


RAM #(.SIZE(1023)) ram2 (); // parameter

endmodule

module mux8 (y, a, b, en);

output reg [7:0] y;
input wire [7:0] a, b;
input wire       en;

endmodule

module mux8_ansi_ports ( 
//	output reg [7:0] y = 0,
	output reg [7:0] y,
	input wire [7:0] a,
	input wire [7:0] b,
	input wire en );   

function [63:0] alu (
	input [63:0] a,
	input[63:0] b,
	input [7:0] opcode);
	alu = (opcode==1) ? a+b : a-b;
endfunction

reg [63:0] alu;

task ansi_port_task (
	input [63:0] a,
	input[63:0] b,
	input [7:0] opcode);
	alu = (opcode==1) ? a+b : a-b;
endtask

endmodule


module ansi_port_list ( 
	output reg [7:0] y,
	input wire [7:0] a,
	output reg [7:0] b,c,
	input wire en );   

always @*
	begin
	if (en)
		begin
		y = a;
		b = a;
		c = a;
		end
	else
		begin
		y = ~a;
		b = ~a;
		c = ~a;
		end
	end

always @( * )
	begin
	end
	
endmodule

module test_port_order;

wire [7:0] y,a,b,c,en;

ansi_port_list c1 (y,a,b,c,en);

endmodule



module new_sigs;

parameter signed p1 = 0;
parameter [31:0] p2 = 0;
parameter signed [31:0] p3 = 0;
parameter integer p4 = 0;
parameter real p5 = 0;
parameter realtime p6 = 0;
parameter time p7 = 0;


realtime rt;
trior t_or;

endmodule




module paramter_port_list 

  ( input  a,
    output b );


initial
	begin
	b = p1;
	#10
	b = p2 > 4;
	#10
	b = (p3 < 75.743);
	#10;
	b = p4 < 2;
	#10;
	b = p5 > 1;
	end

endmodule

