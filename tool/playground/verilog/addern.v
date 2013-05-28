// Due to a bug in the MAX+plusII compiler, this file will not compile if
// the MAX7000S family is selected. Choose FLEX 10K instead.
module addern (carryin, X, Y, S, carryout);
	parameter n=32;
	input carryin;
	input [n-1:0] X, Y;
	output [n-1:0] S;
	output carryout;
	reg [n-1:0] S;
	reg carryout;
	reg [n:0] C;
	integer k;

		always @(X or Y or carryin)
		begin
			C[0] = carryin;
			for (k = 0; k <= n-1; k = k+1)
			begin
				S[k] = X[k] ^ Y[k] ^ C[k];
				C[k+1] = (X[k] & Y[k]) | (X[k] & C[k]) | (Y[k] & C[k]);
 	    	end
			carryout = C[n];
		end

endmodule













