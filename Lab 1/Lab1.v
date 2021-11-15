// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"
// CREATED		"Sun Sep 17 23:34:23 2017"

module Lab1(
	SW,
	LEDR
);


input wire	[5:0] SW;
output wire	[1:0] LEDR;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;




assign	SYNTHESIZED_WIRE_2 = SW[0] & SYNTHESIZED_WIRE_0;

assign	SYNTHESIZED_WIRE_1 = SW[1] & SW[2];

assign	LEDR[0] = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;

assign	SYNTHESIZED_WIRE_0 =  ~SW[1];

assign	SYNTHESIZED_WIRE_3 =  ~SW[3];

assign	SYNTHESIZED_WIRE_4 = SW[4] | SYNTHESIZED_WIRE_3;

assign	LEDR[1] = SYNTHESIZED_WIRE_4 & SW[5];


endmodule
