`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(LEDR, SW, HEX0, HEX1, HEX3, HEX5);

	 input [9:0] SW;
	 output [9:0] LEDR;
	 output [6:0] HEX0, HEX1, HEX3, HEX5;
	 
	 wire adder1out, adder2out, adder3out, adder4out;
	 wire adder1sum, adder2sum, adder3sum, adder4sum;
	 
	 adder adder1(
		 .a(SW[4]),
		 .b(SW[0]),
		 .cin(SW[8]),
		 .cout(adder1out),
		 .sum(adder1sum)
		 );
	 
	 
	 adder adder2(
		 .a(SW[5]),
		 .b(SW[1]),
		 .cin(adder1out),
		 .cout(adder2out),
		 .sum(adder2sum)
		 );
	 
	 adder adder3(
		 .a(SW[6]),
		 .b(SW[2]),
		 .cin(adder2out),
		 .cout(adder3out),
		 .sum(adder3sum)
		 );
	 
	 adder adder4(
		 .a(SW[7]),
		 .b(SW[3]),
		 .cin(adder3out),
		 .cout(adder4out),
		 .sum(adder4sum)
		 );
		 
	 assign LEDR[0] = adder1sum;
	 assign LEDR[1] = adder2sum;
	 assign LEDR[2] = adder3sum;
	 assign LEDR[3] = adder4sum;
	 assign LEDR[9] = adder4out;
	 
	 hexdecoder hex0(
		 .HEX(HEX0),
		 .NUM3(adder4sum),
		 .NUM2(adder3sum),
		 .NUM1(adder2sum),
		 .NUM0(adder1sum)
		 );

	 hexdecoder hex1(
		 .HEX(HEX1),
		 .NUM3(0),
		 .NUM2(0),
		 .NUM1(0),
		 .NUM0(adder4out)
		 );
		 
	 hexdecoder hex3(
		 .HEX(HEX3),
		 .NUM3(SW[7]),
		 .NUM2(SW[6]),
		 .NUM1(SW[5]),
		 .NUM0(SW[4])
		 );

	 hexdecoder hex5(
		 .HEX(HEX5),
		 .NUM3(SW[3]),
		 .NUM2(SW[2]),
		 .NUM1(SW[1]),
		 .NUM0(SW[0])
		 );


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
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? y : x;

endmodule

module hexdecoder(HEX, NUM3, NUM2, NUM1, NUM0);

    input NUM3, NUM2, NUM1, NUM0;
    output [6:0] HEX;
	 
	 segment0 seg0(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[0])
			);
		  
	 segment1 seg1(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[1])
			);
		  
	 segment2 seg2(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[2])
			);
		  
	 segment3 seg3(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[3])
			);
		  
	 segment4 seg4(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[4])
			);
		  
	 segment5 seg5(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
			.out(HEX[5])
			);
		  
	 segment6 seg6(
			.c3(NUM3),
			.c2(NUM2),
			.c1(NUM1),
			.c0(NUM0),
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
