`timescale 1ns / 1ns

module hexdecoder(HEX0, SW);
    input [3:0] SW;
    output [6:0] HEX0;

	 segment0 seg0(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[0])
			);
		  
	 segment1 seg1(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[1])
			);
		  
	 segment2 seg2(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[2])
			);
		  
	 segment3 seg3(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[3])
			);
		  
	 segment4 seg4(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[4])
			);
		  
	 segment5 seg5(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[5])
			);
		  
	 segment6 seg6(
			.c3(SW[3]),
			.c2(SW[2]),
			.c1(SW[1]),
			.c0(SW[0]),
			.out(HEX0[6])
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
