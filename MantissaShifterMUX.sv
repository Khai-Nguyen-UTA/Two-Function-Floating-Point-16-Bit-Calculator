module MantissaShifterMUX
(
	input [9:0] A, B,
	input switch,
	output [9:0] C
);
	always_comb
    begin
        if (switch == 1'b0)
            C = A;    
        else
            C = B;     
    end

endmodule 