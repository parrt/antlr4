
module top;

integer my_num, seed, i;

initial
	begin
	   $display ("-- No Seed --");
		for (i = 1; i <= 5; i=i+1) begin
			my_num = $random;
			$display(my_num);
		end
		$display("-- Seed initially set to 10 --");
		seed = 10;   
		for (i = 1; i <= 5; i=i+1) begin
			my_num = $random(seed);
			$display("Random Numb: %0d   New seed: %0d",my_num,seed);
		end
	end
endmodule

