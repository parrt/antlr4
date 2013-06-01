//----- Synthesizable Circuit -----

module Counter4 (
// Sequential circuit 4

	// Inputs:
	i$Clock,
	i$Reset,
	i$InializeCount,
	i$CountUp,
	i$EnableCount,
	i$N,

	// Outputs:
	o$Count,
	o$AtMidpoint
);

// Port mode declarations:
	// Inputs:
input	i$Clock;
input	i$Reset;
input	i$InializeCount;
input	i$CountUp;
input	i$EnableCount;
input	[3:0]	i$N;

	// Outputs:
output	[7:0]	o$Count;
output	o$AtMidpoint;


// Registered identifiers:
// NOTE: Remove (or comment out) each line for which the 'assign' method is used
reg	[7:0]	o$Count;
//reg	o$AtMidpoint;


// Functionality:

// Counter
always @ (posedge i$Clock or posedge i$Reset)
	if (i$Reset)
		o$Count <= 0;
	else
		if (i$EnableCount)
			if (i$InializeCount)
				o$Count <= 8'd127;
			else
				if (i$CountUp)
					o$Count <= o$Count + i$N;
				else
					o$Count <= o$Count - i$N;

// Comparator	
assign o$AtMidpoint = (o$Count == 8'd127);

endmodule
