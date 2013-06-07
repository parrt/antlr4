module fsm_mealy (Clock, Resetn, w, z); 
  input Clock, Resetn, w; 
  output z; 
  reg y, Y, z; 
  parameter A = 0, B = 1; 

  // Define the next state and output combinational circuits 
  always @(w or y) 
    case (y) 
      A:  if (w) 
        begin 
          z = 0; 
          Y = B; 
        end 
        else 
        begin 
          z = 0; 
          Y = A; 
        end 
      B:  if (w) 
        begin 
          z = 1; 
          Y = B; 
        end 
        else 
        begin 
          z = 0; 
          Y = A; 
        end 
    endcase 

  // Define the sequential block 
  always @(negedge Resetn or posedge Clock) 
    if (Resetn == 0) y <= A; 
    else y <= Y; 

endmodule 
