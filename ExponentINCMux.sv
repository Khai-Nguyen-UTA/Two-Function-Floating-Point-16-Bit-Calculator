module ExponentINCMux
(
	input [4:0] A, B,
	input switch,
	output [4:0] C
);
	always_comb
    begin
        if (switch == 1'b1)
            C = A;    
        else
            C = B;     
    end

endmodule 