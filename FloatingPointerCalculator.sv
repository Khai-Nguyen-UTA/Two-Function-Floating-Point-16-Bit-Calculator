module FloatingPointerCalculator
(
	input [15:0] Ainput,Binput, 
	output [15:0] Result
);

	logic Cout, CarryLookAheadCout;
	logic [10:0] MantissaShifterMuxOut, MantissaAdderMUXOut, MantissaRightShifterOut;
	logic [4:0] ModularExponentSubtractorOut, ExponentINCMuxOut;
	logic [10:0] GLCAOut;
	

MantissaShifterMUX MantissaShifterMUX_inst
(
	.A(Ainput[9:0]) ,						// input [9:0] A_sig
	.B(Binput[9:0]) ,						// input [9:0] B_sig
	.switch(Cout) ,					// input  switch_sig
	.C(MantissaShifterMuxOut) 		// output [9:0] C_sig
);

MantissaAdderMux MantissaAdderMux_inst
(
	.A(Ainput[9:0]) ,					// input [9:0] A_sig
	.B(Binput[9:0]) ,					// input [9:0] B_sig
	.switch(Cout) ,				// input  switch_sig
	.C(MantissaAdderMUXOut) 	// output [9:0] C_sig
);

SubtractorTopLevel SubtractorTopLevel_inst
(
	.A(Ainput[14:10]) ,							// input [4:0] A_sig
	.B(Binput[14:10]) ,							// input [4:0] B_sig
	.solution(ModularExponentSubtractorOut) ,	// output [4:0] solution_sig
	.Cout(Cout) 										// output  Cout_sig
);

assign MantissaShifterMuxOut[10] = 1'b1;
assign MantissaAdderMUXOut[10] = 1'b1;

MantissaRightShifter MantissaRightShifter_inst
(
	.in(MantissaShifterMuxOut) ,					// input [10:0] in_sig
	.ctrl(ModularExponentSubtractorOut) ,		// input [4:0] ctrl_sig
	.shifted(MantissaRightShifterOut) 			// output [10:0] shifted_sig
);

ExponentINCMux ExponentINCMux_inst
(
	.A(Ainput[14:10]) ,					// input [4:0] A_sig
	.B(Binput[14:10]) ,					// input [4:0] B_sig
	.switch(Cout) ,							// input  switch_sig
	.C(ExponentINCMuxOut) 					// output [4:0] C_sig
);

CLAparameter CLAparameter_inst
(
	.A(MantissaRightShifterOut) ,				// input [N-1:0] A_sig
	.B(MantissaAdderMUXOut) ,					// input [N-1:0] B_sig
	.OpCode(1'b0) ,								// input  OpCode_sig
	.R(GLCAOut) ,									// output [N-1:0] R_sig
	.Cout(CarryLookAheadCout) 					// output  Cout_sig
);

FiveIncrementorTP FiveIncrementorTP_inst
(
	.A(ExponentINCMuxOut) ,					// input [4:0] A_sig
	.Select(CarryLookAheadCout) ,			// input  Select_sig
	.S(Result[14:10])						// output [4:0] S_sig
	//.Cout(Cout_sig) 						// output  Cout_sig
);

MantissaNormalizerBitShifter MantissaNormalizerBitShifter_inst
(
	.in(GLCAOut) ,								// input [10:0] in_sig
	.ctrl(CarryLookAheadCout) ,			// input [4:0] ctrl_sig...needs to be a 1
	.shifted(Result[9:0]) 				// output [10:0] shifted_sig
);


endmodule