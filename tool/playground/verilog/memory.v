/*************************************************************************
   Copyright 2008 Ray Salemi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
**************************************************************************/
//
// Verilog Module tiny_cache_lib.memory
//
// Created:
//          by - Owner.UNKNOWN (DADLAPTOP)
//          at - 22:49:36 05/18/2005
//
// using Mentor Graphics HDL Designer(TM) 2005.1 (Build 83)
//

module memory( 
   clk, 
   memory_address, 
   memory_rd, 
   memory_wr, 
   memory_data
);


// Internal Declarations

input        clk;
input  [7:0] memory_address;
input        memory_rd;
input        memory_wr;
inout  [7:0] memory_data;


wire clk;
wire [7:0] memory_address;
wire memory_rd;
wire memory_wr;
wire [7:0] memory_data;

// ### Please start your Verilog code here ### 

reg [7:0] RAM [255:0];
reg [8:0] adr;

assign memory_data = memory_rd ? RAM[memory_address] : 8'hZZ;

initial
  begin
    for (adr = 0; adr <= 255; adr = adr + 1) begin
      RAM[adr] = adr + 1;
    end
  end
  
always @(posedge clk)
  if (memory_wr) RAM[memory_address] = memory_data;
  
endmodule
