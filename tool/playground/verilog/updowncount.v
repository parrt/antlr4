module updowncount(R, Clock, L, E, up_down, Q);
	parameter n=8;
	input [n-1:0] R;
	input Clock, L, E, up_down;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	integer direction;
		
	always @(posedge Clock)
	 	begin
		if (up_down)
			direction = 1;
		else 
			direction = -1;
		if (L)
			Q <= R;
		else if (E)
			Q <= Q + direction;
		end
	
endmodule


















