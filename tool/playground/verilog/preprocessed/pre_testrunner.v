
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
  
  #include "test_tasks.vh"
  
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
