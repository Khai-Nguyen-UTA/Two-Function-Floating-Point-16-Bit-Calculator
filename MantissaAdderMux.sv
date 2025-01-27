module MantissaAdderMux
(
	input [9:0] A, B,
	input switch,
	output [9:0] C
);
	always_comb
    begin
        if (switch == 1'b1)
            C = A;    
        else
            C = B;     
    end

endmodule 