`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(LEDR, SW, KEY);

	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	
	wire [7:0] register_8b;
	
	subCircuit u0(
		.right(register_8b[7]), 
		.left(register_8b[1]),
		.secondaryLeft(register_8b[1]),
		.loadn_ParallelLoadn(KEY[1]),
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]),  
		.D(SW[0]), 
		.Q(register_8b[0])
	);
	
	subCircuit u1(
		.right(register_8b[0]), 
		.left(register_8b[2]),
		.secondaryLeft(register_8b[2]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[1]), 
		.Q(register_8b[1])
	);
	
	subCircuit u2(
		.right(register_8b[1]), 
		.left(register_8b[3]),
		.secondaryLeft(register_8b[3]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[2]), 
		.Q(register_8b[2])
	);
	
	subCircuit u3(
		.right(register_8b[2]), 
		.left(register_8b[4]),
		.secondaryLeft(register_8b[4]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[3]), 
		.Q(register_8b[3])
	);
	
	subCircuit u4(
		.right(register_8b[3]), 
		.left(register_8b[5]),
		.secondaryLeft(register_8b[5]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[4]), 
		.Q(register_8b[4])
	);
	
	subCircuit u5(
		.right(register_8b[4]), 
		.left(register_8b[6]),
		.secondaryLeft(register_8b[6]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[5]), 
		.Q(register_8b[5])
	);
	
	subCircuit u6(
		.right(register_8b[5]), 
		.left(register_8b[7]),
		.secondaryLeft(register_8b[7]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[6]), 
		.Q(register_8b[6])
	);
	
	subCircuit u7(
		.right(register_8b[6]), 
		.left(register_8b[0]),
		.secondaryLeft(register_8b[7]),
		.loadn_ParallelLoadn(KEY[1]), 
		.LoadLeft_RotateRight(KEY[2]), 
		.ASRightSel(KEY[3]),
		.Clock(KEY[0]), 
		.reset(SW[9]), 
		.D(SW[7]), 
		.Q(register_8b[7])
	);

	assign LEDR[7:0] = register_8b[7:0];

endmodule

module DFF_SR_HIGH(reset, Clock, D, Q);

	input reset, Clock;
	input D;
	output Q;
	
	reg Q;

	always @(posedge Clock) // triggered every time clock rises
	begin
		if (reset) 				// when reset is 1 (note this is tested on every rising clock edge) SYNCHRONOUS ACTIVE HIGH RESET
			Q <= 0;			   // q is set to 0. Note that the assignment uses <=
		else 						// when reset is not 0
			Q <= D; 				// value of d passes through to output q
	end

endmodule

module mux2to1(x, y, s, m);

    input x, y, s;
    output m;
  
    //assign m = s & y | ~s & x;
	 
    assign m = s ? y : x;

endmodule

module subCircuit(right, left, secondaryLeft, loadn_ParallelLoadn, LoadLeft_RotateRight, ASRightSel, Clock, reset, D, Q);

	input right, left, secondaryLeft, loadn_ParallelLoadn, LoadLeft_RotateRight, ASRightSel, Clock, reset, D;
	output Q;
	
	wire ASRightMuxOut, RotateRightMuxOut, ParallelLoadnMuxOut;
	
	mux2to1 ASRightMux(
		.x(left),
		.y(secondaryLeft),
		.s(ASRightSel),
		.m(ASRightMuxOut)
	);
	
	mux2to1 RotateRightMux(
		.x(right),
		.y(ASRightMuxOut),
		.s(LoadLeft_RotateRight),
		.m(RotateRightMuxOut)
	);
	
	mux2to1 ParallelLoadnMux(
		.x(D),
		.y(RotateRightMuxOut),
		.s(loadn_ParallelLoadn),
		.m(ParallelLoadnMuxOut)
	);
	
	DFF_SR_HIGH u0(
		.reset(reset), 
		.Clock(Clock), 
		.D(ParallelLoadnMuxOut), 
		.Q(Q)
	);
	
endmodule

