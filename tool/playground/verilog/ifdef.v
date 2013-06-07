module Demo_ifdef (a,b);

// Demonstrates use of "#ifdef" compiler directive to set a paramter
// to one value for simulation and another value for synthesis.

// The technique is particularly useful for clock divider (frequency
// divider) circuits that require a small value for simulation and
// a large value for synthesis.

// A compiler directive begins with a backwards apostrophe (`); look
// at the upper left of your keyboard for this character. The #ifdef
// directive checks whether a particular symbol is defined (thus,
// ("ifdef" is an abbreviation for "if defined"). If the symbol has
// been previously defined, then subsequent Verilog statements are compiled
// until an #else or #endif is encountered. Note that no "begin-end" is
// required here as is typical for other Verilog multi-statement blocks.
// If the symbol is not defined, then compilation resumes after the #else
// directive.

// You can define a symbol as part of the simulator environment, making
// it easy for your Verilog description to automatically determine 
// whether you are doing functional verification (simulation) or
// synthesis.

// Do the following steps in Silos to define the symbol "SIM":
//
//   1. Select "Project | Project Settings..."
//   2. Enter "SIM" in the "#defines" text entry box
//   3. Click "Add" button, then click "OK" button
//
// In Xilinx ISE, you need specifically indicate that you want to use
// the #ifdef compiler directive (otherwise you will get an "undefined
// macro" error); do this:
//
//   1. Right-click on the "Synthesis" process and select "Properties..."
//   2. Check the "Enable Verilog Preprocessor" checkbox
//   3. Click "OK"



// Module has two output ports
output a,b;

#ifdef SIM
	// Verilog statements for simulation:
	parameter OutputA = 1;
	parameter OutputB = 0;
#else
	// Verilog statements for synthesis:
	parameter OutputA = 0;
	parameter OutputB = 1;
#endif

// Create the two output values. Simulation and synthesis will
// produce different values for outputs "a" and "b".
assign a = OutputA;
assign b = OutputB;


// End of description
endmodule
	
