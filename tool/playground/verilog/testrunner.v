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
// Verilog Module tiny_cache_lib.testrunner
//
// Created:
//          by - Owner.UNKNOWN (DADLAPTOP)
//          at - 11:27:04 05/19/2005
//
// using Mentor Graphics HDL Designer(TM) 2005.1 (Build 83)
//

module testrunner( 
  cpubus_data_reg, 
  transaction_req, 
  go, 
  done, 
  cpubus_address, 
  rst
  );
  
  `include "test_tasks.vh"
  
  initial
  begin : tests
    rst = 0;
    #100;
    rst = 1;
    reset();
    for (i = 0; i<=7;i=i+1) 
    begin
      read(i);
      read(i);
    end	   
    $finish;
  end // block: tests
  
endmodule
