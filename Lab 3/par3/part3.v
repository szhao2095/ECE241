`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(LEDR, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);

	input [8:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	
	wire [7:0] part2AdderOut, verilogAdderOut, orXorOut, orOut, andOut, sigInsigOut;

	reg [7:0] ALUout;
	
	adder4and4 u0(
		.a(SW[7:4]), 
		.b(SW[3:0]), 
		.carryIn(SW[8]), 
		.sum8b(part2AdderOut[7:0])
	);
	
	verilogAdder u1(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.carryIn(SW[8]),
		.sum8b(verilogAdderOut[7:0])
	);
	
	orXor u2(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.out(orXorOut[7:0])
	);
	
	orCheck u3(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.out(orOut[7:0])
	);
	
	andCheck u4(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.out(andOut[7:0])
	);
	
	sigInsig u5(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.out(sigInsigOut[7:0])
	);
	
	
	always @(*) // declare always block
	begin
		case (KEY) // start case statement
			3'b000: ALUout = part2AdderOut;			//A + B using the adder from Part II of this Lab
			3'b001: ALUout = verilogAdderOut;		//A + B using the Verilog ‘+’ operator
			3'b010: ALUout = orXorOut;				//A XOR B in the lower four bits and A OR B in the upper four bits
			3'b011: ALUout = orOut;					//Output 8’b00011000 if at least 1 of the 8 bits in the two inputs is 1 using a single OR operation
			3'b100: ALUout = andOut;					//Output 8’b11100111 if all of the 8 bits in the two inputs are 1 using a single AND operation
			3'b101: ALUout = sigInsigOut;			//Display the A switches in the most significant four bits and the complement of the B switches in the least significant four bits without complementing the bits individually
			default: ALUout = 8'b00000000;
		endcase
	end
	
	hexdecoder hex0(
		.HEX(HEX0),
		.NUM(SW[3:0])
	);
	
	hexdecoder hex1(
		.HEX(HEX1),
		.NUM(0)
	);
	
	hexdecoder hex2(
		.HEX(HEX2),
		.NUM(SW[7:4])
	);
	
	hexdecoder hex3(
		.HEX(HEX3),
		.NUM(0)
	);
	
	hexdecoder hex4(
		.HEX(HEX4),
		.NUM(ALUout[3:0])
	);
	
	hexdecoder hex5(
		.HEX(HEX5),
		.NUM(ALUout[7:4])
	);
	
	assign LEDR[7:0] = ALUout[7:0];

endmodule

module adder4and4(a, b, carryIn, sum8b);

	input [3:0] a, b;
	input carryIn;
	output [7:0] sum8b;
	
	wire [3:0] adderCarryOut, adderSum;
	
	adder adder0(
		.a(a[0]),
		.b(b[0]),
		.cin(carryIn),
		.cout(adderCarryOut[0]),
		.sum(adderSum[0])
	);
	
	adder adder1(
		.a(a[1]),
		.b(b[1]),
		.cin(adderCarryOut[0]),
		.cout(adderCarryOut[1]),
		.sum(adderSum[1])
	);
	
	adder adder2(
		.a(a[2]),
		.b(b[2]),
		.cin(adderCarryOut[1]),
		.cout(adderCarryOut[2]),
		.sum(adderSum[2])
	);
	
	adder adder3(
		.a(a[3]),
		.b(b[3]),
		.cin(adderCarryOut[2]),
		.cout(adderCarryOut[3]),
		.sum(adderSum[3])
	);
	
	assign sum8b[3:0] = adderSum [3:0];
	assign sum8b[4] = adderCarryOut[3];
	assign sum8b[7:5] = 0;

endmodule

module adder(a, b, cin, cout, sum);
 
	input a, b, cin;
	output cout, sum;
	 
	wire xor1out;
 
	xor xor1(xor1out, a, b);
	xor xor2(sum, cin, xor1out);
	
	mux2to1 u0(
		 .x(b), 
		 .y(cin), 
		 .s(xor1out), 
		 .m(cout)
		 );
		 
endmodule
 
module mux2to1(x, y, s, m);

    input x, y, s;
    output m;
  
    //assign m = s & y | ~s & x;
	 
    assign m = s ? y : x;

endmodule

module verilogAdder(a, b, carryIn, sum8b);

	input [3:0] a, b;
	input carryIn;
	output [7:0] sum8b;
	
	assign sum8b = a + b + carryIn;

endmodule

module orXor(a, b, out);

	input [3:0] a, b;
	output [7:0] out;
	
	assign out[3:0] = a ^ b;
	assign out[7:4] = a | b;

endmodule

module orCheck(a, b, out);
	
	input [3:0] a, b;
	output [7:0] out;
	
	reg [7:0] out;
	
	wire orOut;
	
	or(orOut, a[3], a[1], a[2], a[0], b[3], b[1], b[2], b[0]);
	
	always @(orOut)
	begin
		if (orOut)
			out = 8'b00011000;
		else
			out = 8'b00000000;
	end
	
endmodule

module andCheck(a, b, out);
	
	input [3:0] a, b;
	output [7:0] out;
	
	reg [7:0] out;
	
	wire andOut;
	
	and(andOut, a[3], a[1], a[2], a[0], b[3], b[1], b[2], b[0]);
	
	always @(andOut)
	begin
		if (andOut)
			out = 8'b11100111;
		else
			out = 8'b00000000;
	end
	
endmodule

module sigInsig(a, b, out);
	
	input [3:0] a, b;
	output [7:0] out;
	
	assign out[7:4] = a[3:0];
	assign out[3:0] = ~b[3:0];

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
