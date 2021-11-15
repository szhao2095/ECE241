`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
	 
	 wire wire0, wire1;

	 //instantiating 2 mux2to1 and chain the outputs to the third instances to create a mux4to1
    mux2to1 u0(
        .a(SW[0]),
        .b(SW[1]),
        .s(SW[8]),
        .m(wire0)
        );
		  
    mux2to1 u1(
        .a(SW[2]),
        .b(SW[3]),
        .s(SW[8]),
        .m(wire1)
        );
		  
    mux2to1 u2(
        .a(wire0),
        .b(wire1),
        .s(SW[9]),
        .m(LEDR[0])
        );
		  
endmodule

module mux2to1(a, b, s, m);
    input a; //select 0
    input b; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? b : a;

endmodule