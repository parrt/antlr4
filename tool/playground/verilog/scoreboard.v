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
// Verilog Module tiny_cache_lib.scoreboard
//
// Created:
//          by - rsalemi.UNKNOWN (MAW-RSALEMI-LT)
//          at - 15:35:11 05/24/2005
//
// using Mentor Graphics HDL Designer(TM) 2005.1 (Build 83)
//


module scoreboard( 
   active, 
   clk, 
   cpu_rd, 
   cpu_wr, 
   cpubus_address, 
   cpubus_data, 
   reset, 
   response, 
   trans, 
   memory_data, 
   memory_address, 
   memory_rd, 
   memory_wr
);

// synopsys template
// ### Please start your Verilog code here ###
// synopsys template
// synopsys template
parameter NOTHING     = 0,
          READ        = 1,
          WRITE       = 2,
          RESET       = 3,
          CACHEHIT    = 4,
          CACHEMISS   = 5,
          CACHEWRITE  = 6,
          CACHERESET  = 7,
          MEMORYREAD  = 1,
          MEMORYWRITE = 2;

// Internal Declarations

input        active;
input        clk;
input        cpu_rd;
input        cpu_wr;
input  [7:0] cpubus_address;
input  [7:0] cpubus_data;
input        reset;
input        response;
input  [2:0] trans;
input  [7:0] memory_data;
input  [7:0] memory_address;
input        memory_rd;
input        memory_wr;


wire active;
wire clk;
wire cpu_rd;
wire cpu_wr;
wire [7:0] cpubus_address;
wire [7:0] cpubus_data;
wire reset;
wire response;
wire [2:0] trans;
wire [7:0] memory_data;
wire [7:0] memory_address;
wire memory_rd;
wire memory_wr;


reg [2:0] predicted_transaction;
reg [7:0] predicted_address, predicted_data, predicted_mem_addr, predicted_mem_data;
reg [1:0] predicted_memory_tran, actual_memory_tran;
reg cpubus_error, memory_error;

wire memory_response;


reg [7:0] RAM [255:0];
reg [7:0] cache_ram[15:0];
reg [7:0] key [15:0];
reg [15:0] valid;
reg [8:0] adr;

assign memory_response = memory_wr | memory_rd;

initial
  begin
    for (adr = 0; adr <= 255; adr = adr + 1) begin
      RAM[adr] = adr + 1;
    end
    valid = 0;
  end


function [36:0] cachemodel; // function definition
 input [2:0] req;  
 input [7:0] address, data;  
 reg [3:0] cache_address;
 reg [7:0] return_data, memory_address, memory_data;
 reg [2:0] response;
 reg [1:0] memory_transaction;
 begin
 cache_address = address % 16;
   case (req)
     RESET:
       begin
         valid = 0;
         response = CACHERESET;
         return_data = 0;
       end
     READ:
         if ((key[cache_address] == address) && valid[cache_address]) 
           begin
             return_data = cache_ram[cache_address];
             response = CACHEHIT;
             memory_transaction = NOTHING;
             memory_address = address;
             memory_data = data;
           end
         else
           begin
             cache_ram[cache_address] = RAM[address];
             valid[cache_address] = 1'b1;
             key[cache_address] = address;
             response = CACHEMISS;
             return_data = cache_ram[cache_address];
             memory_transaction = MEMORYREAD;
             memory_address = address;
             memory_data = return_data;
           end
      WRITE:
         begin
           cache_ram[cache_address] = data;
           valid[cache_address] = 1'b1;
           key[cache_address]= address;
           RAM[address] = data;
           return_data = data;
           response = CACHEWRITE;
           memory_transaction = MEMORYWRITE;
           memory_address = address;
           memory_data = return_data;
         end
      default:
         begin
           $display ("Bad request value: %d ", req);
           $stop;
         end
    endcase
       cachemodel = {response, address, return_data, 
                      memory_transaction, memory_address, memory_data};   
end
endfunction


always @(negedge clk)
begin
 if (cpu_rd && !active)
      {predicted_transaction, predicted_address, predicted_data,
        predicted_memory_tran, predicted_mem_addr, predicted_mem_data} = 
          cachemodel(READ,cpubus_address,cpubus_data);

 if (cpu_wr && !active)
   begin
      {predicted_transaction, predicted_address, predicted_data,
         predicted_memory_tran, predicted_mem_addr, predicted_mem_data} = 
            cachemodel(WRITE,cpubus_address,cpubus_data);

   end
  if (reset && !active)
       {predicted_transaction, predicted_address, predicted_data,
         predicted_memory_tran, predicted_mem_addr, predicted_mem_data} = 
             cachemodel(RESET,cpubus_address,cpubus_data);
    
end
 

always @(posedge clk)
begin
  memory_error = 0;
  cpubus_error = 0;
  if (response)
    begin
        cpubus_error = 0;
        if (trans == CACHERESET)
          cpubus_error = (predicted_transaction != CACHERESET);
        else
          cpubus_error = {predicted_transaction, predicted_address, predicted_data}!=
                  {trans, cpubus_address, cpubus_data};
//       $display ("cpu predicted transaction: %h",{predicted_transaction, predicted_address, predicted_data});
//       $display ("   cpu actual transaction: %h",{trans, cpubus_address, cpubus_data});
    end
    
    if (memory_response)
      begin
        if (memory_rd) 
          actual_memory_tran = MEMORYREAD;
        else
          actual_memory_tran = MEMORYWRITE;
          
         memory_error = {predicted_memory_tran, predicted_mem_addr, predicted_mem_data} !=
                       {actual_memory_tran, memory_address, memory_data};
//         $display ("mem predicted transaction: %h",{predicted_memory_tran, predicted_mem_addr, predicted_mem_data});
//         $display ("   mem actual transaction: %h",{actual_memory_tran, memory_address, memory_data});

      end
                 
    if (cpubus_error || memory_error)
          begin
            
            if (cpubus_error) 
              begin
                $display($time,,"CPUBUS ERROR: Predicted TRAN: %h, ADDRESS: %h, DATA: %h", predicted_transaction, predicted_address, predicted_data);
                $display($time,,"CPUBUS ERROR: Actual    TRAN: %h, ADDRESS: %h, DATA: %h",  trans, cpubus_address, cpubus_data);
              end
              
            if (memory_error)
              begin
                 $display($time, ,"MEMORY ERROR: Predicted TRAN: %h, ADDRESS: %h, DATA: %h", predicted_transaction, predicted_address, predicted_data);
                 $display($time, ,"MEMORY ERROR: Actual    TRAN: %h, ADDRESS: %h, DATA: %h",  trans, memory_address, memory_data);
              end  
           end
  end

endmodule
