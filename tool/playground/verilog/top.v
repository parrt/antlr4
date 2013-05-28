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

