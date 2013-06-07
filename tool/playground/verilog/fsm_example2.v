//===== Finite State Machine Example =====

//----- Synthesizable Circuit -----

module FSM_Example (
	// Inputs:
	i$Clock,	// Master clock
	i$Reset,	// Master reset (active high)
	i$A,
	i$B,
	i$C,

	// Outputs:
	o$D,
	o$E,
	o$F
);

// Port mode declarations:
	// Inputs:
input	i$Clock;
input	i$Reset;
input	i$A;
input	i$B;
input	i$C;

	// Outputs:
output	o$D;
output	o$E;
output	o$F;


// Registered identifiers:
// NOTE: Remove (or comment out) each line for which the 'assign' method is used
reg	o$D;
reg	o$E;
reg	o$F;


// Functionality:


// Declare parameters to represent the state bit patterns
parameter p$s0 = 3'b000;
parameter p$s1 = 3'b001;
parameter p$s2 = 3'b010;
parameter p$s3 = 3'b011;
parameter p$s4 = 3'b100;

// Declare outputs of each circuit block
reg [2:0] r$State, r$NextState;


// State register
always @ (posedge i$Clock or posedge i$Reset)
	if (i$Reset)
		r$State <= p$s0;
	else
		r$State <= r$NextState;

// Output decoder
always @ (r$State) begin
	o$D <= (r$State == p$s1 || r$State == p$s4);
	o$E <= (r$State == p$s2);
	o$F <= (r$State == p$s3);
end

// Next state decoder
always @ (r$State or i$A or i$B or i$C)
	case (r$State)
		p$s0: r$NextState <= (i$A) ? p$s4 : p$s1;
		p$s1: r$NextState <= p$s2;
		p$s2: r$NextState <= p$s3;
		p$s3: if (i$B)
			r$NextState <= (i$C) ? p$s4 : p$s0;
			else
			r$NextState <= p$s3;
		p$s4: r$NextState <= p$s0;
		default: r$NextState <= p$s0;
	endcase


endmodule
