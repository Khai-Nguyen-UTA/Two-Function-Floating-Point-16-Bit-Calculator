module FiveIncrementorTP
(
	input [4:0] A,
	input Select,
	output [4:0] S,
	output Cout

);

	logic [4:0] C;
	//assign C[0] = Select;
	assign Cout = C[4];
	
	HalfAdder F0( S[0], C[0], A[0], Select);
	FullAdder F1( A[1], 1'b0, C[0], S[1], C[1] );
	FullAdder F2( A[2], 1'b0, C[1], S[2], C[2] );
	FullAdder F3( A[3], 1'b0, C[2], S[3], C[3] );
	FullAdder F4( A[4], 1'b0, C[3], S[4], C[4] );


endmodule 