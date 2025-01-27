module CLAparameter #(parameter N = 11)
(
	input [N-1:0] A,
	input [N-1:0] B,
	input OpCode,
	output [N-1:0] R,
	output Cout
);

	wire [N:0] C;
	wire [N-1:0] SUM;
	wire [N-1:0] B_effective;
	
	assign B_effective = B ^ {N{OpCode}};
	assign C[0] = OpCode; //0 subtraction / 1 addition 
	
	genvar i;
	generate 
		for (i=0; i<N; i=i+1)
		begin: FullAdderFor
		FAbehav FAbehav_inst
		(
			.s(SUM[i]) ,			// output  s_sig
			.cout(C[i+1]) ,		// output  cout_sig
			.a(A[i]) ,				// input  a_sig
			.b(B_effective[i]) ,				// input  b_sig
			.cin(C[i]) 				// input  cin_sig
		);
		end 
	endgenerate
		
		assign R = SUM;
		assign Cout = C[N]; 
		
endmodule 