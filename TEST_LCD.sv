module TEST_LCD
	 (input                clk       , // 50MHz Clock
	  inout    [7:0]       lcd_data  , // LCD Data Bus
	  input 					  trig, LoadA, LoadB, LoadC, IUreset,
	  output               lcd_rs    , // LCD Register Select
	  output               lcd_rw    , // LCD Read Write Select
	  output               lcd_e     , // LCD Execute
	  input                lcd_reset , // LCD Reset
	  input 	  [3:0] 		  row_sig   ,
	  output   [3:0]       column_sig
	  );

	logic [3:0] IU_output;
	logic [19:0] shift_reg;
	logic [15:0] Areg, Breg, Creg;
	logic [15:0] BSM2comp;
	//logic LoadA, LoadB, LoadC;

	keypad_input KeypadInput
	(
		.clk(clk) ,						// input  clk_sig
		.reset(IUreset) ,				// input  reset_sig
		.row(row_sig) ,				// input [3:0] row_sig
		.col(column_sig) ,			// output [3:0] col_sig
		.out(shift_reg) ,				// output [DIGITS*4-1:0] out_sig
		.value(IU_output) ,			// output [3:0] value_sig
		//.trig(trig)
	);
	
	NBitRegister LoadAr
	(
		.D(shift_reg) ,			// input [N-1:0] D_sig
		.CLK(LoadA) ,			// input  CLK_sig
		.CLR(lcd_reset) ,		// input  CLR_sig
		.Q(Areg) 				// output [N-1:0] Q_sig
	);
	NBitRegister LoadBr
	(
		.D(shift_reg) ,			// input [N-1:0] D_sig
		.CLK(LoadB) ,			// input  CLK_sig
		.CLR(lcd_reset) ,		// input  CLR_sig
		.Q(Breg) 				// output [N-1:0] Q_sig
	);
	
	logic[15:0] CalculatorOutput;
	
	FloatingPointerCalculator FloatingPointerCalculator_inst
	(
		.Ainput(Areg) ,	// input [15:0] Ainput_sig
		.Binput(Breg) ,	// input [15:0] Binput_sig
		.Result(CalculatorOutput) 		// output [15:0] Result_sig
	);
	
	NBitRegister LoadCr
	(
		.D(CalculatorOutput) ,			// input [N-1:0] D_sig
		.CLK(LoadC) ,			// input  CLK_sig
		.CLR(lcd_reset) ,		// input  CLR_sig
		.Q(Creg) 				// output [N-1:0] Q_sig
	);
	  
	LCD #(
		 .WIDTH(64),
		 .DIGITS(16),
		 .FLOAT(0),
		 .MODE(1),
		 .LINES(4),
		 .CHARS(20),
		 .LINE_STARTS({7'h00, 7'h40, 7'h14, 7'h54})
		 )(
		 .clk(clk),
		 .lcd_data(lcd_data),
		 .lcd_rs(lcd_rs),
		 .lcd_rw(lcd_rw),
		 .lcd_e(lcd_e),
		 .lcd_reset(!lcd_reset),
		 .A(Areg),
		 .B(Breg),
		 .C(Creg),
		 .Operation(2'b01)
	);

endmodule
