module flipflop_areset(D, Clock, Resetn, Q);
	input D, Clock, Resetn;
	output Q;
	reg Q;
	
	always @(negedge Resetn or posedge Clock)
		if (!Resetn)
			Q <= 0;
		else 
			Q <= D;
	
endmodule










