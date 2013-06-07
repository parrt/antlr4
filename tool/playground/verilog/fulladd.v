module fulladd (Cin, x, y, s, Cout);
	input Cin, x, y;
	output s, Cout;
	reg s, Cout;
	
	always @(x or y or Cin)
		{Cout, s} = x + y + Cin;

endmodule


