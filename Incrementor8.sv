module Incrementor8
(
	input [7:0] A,
	input Select,
	output [7:0] S, LEDGs,
	output Cout
);
	logic [7:0] Lights;
	assign Lights = A;
	assign LEDGs = Lights;
	logic [7:0] C;
	//assign C[0] = Select;
	assign Cout = C[7];
	
HalfAdder F0( S[0], C[0], A[0], Select);
FullAdder F1( A[1], 1'b0, C[0], S[1], C[1] );
FullAdder F2( A[2], 1'b0, C[1], S[2], C[2] );
FullAdder F3( A[3], 1'b0, C[2], S[3], C[3] );
FullAdder F4( A[4], 1'b0, C[3], S[4], C[4] );
FullAdder F5( A[5], 1'b0, C[4], S[5], C[5] );
FullAdder F6( A[6], 1'b0, C[5], S[6], C[6] );
FullAdder F7( A[7], 1'b0, C[6], S[7], C[7] );

endmodule 