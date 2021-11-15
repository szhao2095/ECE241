`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(KEY, SW, HEX0, Clock_50);

	input [1:0] KEY;
	input Clock_50;
	input [5:0] SW;
	output [6:0] HEX0;

	reg [3:0] counter; 
	
	wire Enable;
	
	//converts 50MHz to the one desired
	rateDivider rd0(
		.SW(SW[1:0]),
		.givenCLK(Clock_50),
		.Enable(Enable),
		.Reset_n(KEY[0])
	);
	
	always @(posedge Clock_50) 
	begin
		if (!KEY[0]) 
			 counter <= 0; 
		else if (!KEY[1]) 
			counter <= SW[5:2];
		else if (counter == 4'b1111) 
			counter <= 0; 
		else if (Enable) 
			counter <= counter + 1; 
	end

	hexdecoder h0(
		.HEX(HEX0),
		.NUM(counter)
	);
	
endmodule

module rateDivider(SW, givenCLK, Enable, Reset_n);
	
	input [1:0] SW;
	input givenCLK, Reset_n;
	output Enable;
	
	reg [25:0] counter;
	reg Enable;

	always @(posedge givenCLK, negedge Reset_n)
	begin
		if(!Reset_n)
		begin
			counter <= 26'd0;
			Enable <= 1'b0;
		end
		else if(SW[1:0] == 2'b00) //full speed so enable can tick at the same rate as clock posedge
		begin
			counter <= 26'd0;
			Enable = 1'b1;
		end
		else if(SW[1:0] == 2'b01 && counter == 26'd49999999) //actual 49,999,999 //test 4,999
		begin
			counter <= 26'd0;
			Enable = 1'b1;
		end
		else if(SW[1:0] == 2'b10 && counter == 26'd99999999) //actual 99,999,999 //test 9,999
		begin
			counter <= 26'd0;
			Enable = 1'b1;
		end
		else if(SW[1:0] == 2'b11 && counter == 26'd199999999) //actual 199,999,999 //test 19,999
		begin
			counter <= 26'd0;
			Enable = 1'b1;
		end
		else
		begin
			counter<=counter+1;
			Enable <= 1'b0;
		end
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
