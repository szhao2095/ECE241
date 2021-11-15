`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part1(KEY, SW, HEX0, HEX1);

	input [0:0] KEY;
	input [1:0] SW;
	output [6:0] HEX0, HEX1;
	
	wire [7:0] register_8b;
	
	wire [6:0] andOutput;
	
	TFF_POS_AR_LOW tff0(
		.T(SW[1]),
		.Q(register_8b[0]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[0], SW[1], register_8b[0]);
	
	TFF_POS_AR_LOW tff1(
		.T(andOutput[0]),
		.Q(register_8b[1]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[1], andOutput[0] ,register_8b[1]);
	
	TFF_POS_AR_LOW tff2(
		.T(andOutput[1]),
		.Q(register_8b[2]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[2], andOutput[1] ,register_8b[2]);
	
	TFF_POS_AR_LOW tff3(
		.T(andOutput[2]),
		.Q(register_8b[3]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[3], andOutput[2] ,register_8b[3]);
	
	TFF_POS_AR_LOW tff4(
		.T(andOutput[3]),
		.Q(register_8b[4]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[4], andOutput[3] ,register_8b[4]);
	
	TFF_POS_AR_LOW tff5(
		.T(andOutput[4]),
		.Q(register_8b[5]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[5], andOutput[4] ,register_8b[5]);
	
	TFF_POS_AR_LOW tff6(
		.T(andOutput[5]),
		.Q(register_8b[6]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	and(andOutput[6], andOutput[5] ,register_8b[6]);
	
	TFF_POS_AR_LOW tff7(
		.T(andOutput[6]),
		.Q(register_8b[7]),
		.Clock(KEY[0]),
		.Clear_b(SW[0])
	);
	
	hexdecoder h0(
		.HEX(HEX0), 
		.NUM(register_8b[3:0])
	);
	
	hexdecoder h1(
		.HEX(HEX1), 
		.NUM(register_8b[7:4])
	);
	
endmodule

module TFF_POS_AR_LOW(T, Q, Clock, Clear_b);
	
	input T, Clock, Clear_b;
	output Q;
	
	reg Q;
	
	always @(posedge Clock, negedge Clear_b)
	begin
		if (!Clear_b)
			Q <= 1'b0;
		else if (T)
			Q = ~Q;
	end
	
endmodule

module hexdecoder(HEX, NUM);

    input [3:0] NUM;
    output [6:0] HEX;
	 
	 segment0 seg0(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[0])
			);
		  
	 segment1 seg1(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[1])
			);
		  
	 segment2 seg2(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[2])
			);
		  
	 segment3 seg3(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[3])
			);
		  
	 segment4 seg4(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[4])
			);
		  
	 segment5 seg5(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[5])
			);
		  
	 segment6 seg6(
			.c3(NUM[3]),
			.c2(NUM[2]),
			.c1(NUM[1]),
			.c0(NUM[0]),
			.out(HEX[6])
			);
		  
endmodule

module segment0(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & ~c2 & ~c1) | (c3 & ~c0) | (c2 & c1) | (c2 & c0 & ~c3) | (c1 & ~c3) | (~c2 & ~c0));
	 
endmodule

module segment1(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & c0 & ~c1) | (c1 & c0 & ~c3) | (~c3 & ~c1 & ~c0) | (~c2 & ~c1) | (~c2 & ~c0));
	 
endmodule

module segment2(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & ~c2) | (~c3 & c2) | (~c3 & c0) | (~c1 & c0) | (~c3 & ~c1));
	 
endmodule

module segment3(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & c2 & ~c0) | (c3 & ~c1 & ~c0) | (c2 & c0 & ~c1) | (c1 & c0 & ~c2) | (c1 & ~c3 & ~c0) | (~c3 & ~c2 & ~c0) | (~c2 & ~c1 & ~c0));
	 
endmodule

module segment4(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & c2) | (c3 & c1) | (c1 & ~c0) | (~c2 & ~c0));
	 
endmodule

module segment5(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & c1) | (c3 & ~c2) | (~c3 & c2 & ~c1) | (c2 & ~c0) | (~c1 & ~c0));
	 
endmodule

module segment6(c3, c2, c1, c0, out);
	 input c3, c2, c1, c0;
	 output out;
	 
	 assign out = !((c3 & c0) | (c3 & ~c2) | (~c3 & c2 & ~c1) | (c1 & ~c2) | (c1 & ~c0));
	 
endmodule
