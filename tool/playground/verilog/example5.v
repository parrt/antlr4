// Behavioral specification
module example5 (x1, x2, x3, f);
	input x1, x2, x3;
	output f;
	reg f;

	always @(x1 or x2 or x3)
		if (x2 == 1)
			f = x1;
		else
			f = x3;
	
endmodule

		
		