// Part 2 skeleton

module part2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		KEY,
		SW
	);

	input			CLOCK_50;				//	50 MHz
	
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	
	// Own inputs
	input [3:0] KEY;
	input [9:0] SW;

	// To VGA
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	wire [14:0] xy;
	
	wire go;
	wire resetn;
	wire blackscreen;
	wire write;
	
	assign resetn = KEY[0];
	assign write = ~KEY[1];
	assign blackscreen = ~KEY[2];
	assign go = ~KEY[3];
	assign x = xy[14:7];
	assign y = xy[6:0];

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	handler u0(
		.CLOCK_50(CLOCK_50),
		.resetn(resetn),
		.go(go),
		.blackscreen(blackscreen),
		.write(write),
		.inputSW(SW[9:0]),
		.xy(xy),
		.colour(colour),
		.writeEn(writeEn)
		);
	
endmodule

module handler(CLOCK_50, resetn, go, blackscreen, write, inputSW, xy, colour, writeEn);

	input CLOCK_50, resetn, go, blackscreen, write;
	input [9:0] inputSW;
	output [14:0] xy;
	output [2:0] colour;
	output writeEn;
	
	wire ld_x, ld_y, ld_colour;
	wire sel_xy_out, sel_colour, square_counter_enable, blackscreen_counter_enable, square_done, blackscreen_done;
	
	control u1(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn), 
		.go(go),
		.write(write),
		.blackscreen(blackscreen),
		.ld_x(ld_x), 
		.ld_y(ld_y), 
		.ld_colour(ld_colour),
		.sel_xy_out(sel_xy_out),
		.sel_colour(sel_colour),
		.writeEn(writeEn),
		.square_counter_enable(square_counter_enable),
		.blackscreen_counter_enable(blackscreen_counter_enable),
		.square_done(square_done),
		.blackscreen_done(blackscreen_done)
		);
	
	datapath u2(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn),
		.ld_x(ld_x), 
		.ld_y(ld_y),
		.ld_colour(ld_colour),
		.sel_xy_out(sel_xy_out),
		.sel_colour(sel_colour),
		.inputSW(inputSW), 
		.xy(xy),
		.colour(colour),
		.square_counter_enable(square_counter_enable),
		.blackscreen_counter_enable(blackscreen_counter_enable),
		.square_done(square_done),
		.blackscreen_done(blackscreen_done),
		.writeEn(writeEn)
		);
	
endmodule

module control(CLOCK_50, resetn, go, write, blackscreen, ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, writeEn, square_counter_enable, blackscreen_counter_enable, square_done, blackscreen_done);

	input CLOCK_50, resetn, go, write, blackscreen, square_done, blackscreen_done;
	output ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, writeEn, square_counter_enable, blackscreen_counter_enable;
	
	reg ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, writeEn, square_counter_enable, blackscreen_counter_enable;
	
	reg [2:0] current_state, next_state; 
	
	localparam  LOAD_X				= 3'b001,
					LOAD_X_WAIT			= 3'b010,
					LOAD_Y				= 3'b011,
					LOAD_Y_WAIT			= 3'b100,
					SQUARE				= 3'b101,
					BLACKSCREEN			= 3'b110;
    
// Next state logic aka our state table
	always@(*)
	begin:state_table 
		case (current_state)
			LOAD_X: next_state = blackscreen ? BLACKSCREEN : (write ? SQUARE : (go ? LOAD_X_WAIT : LOAD_X));
			LOAD_X_WAIT: next_state = blackscreen ? BLACKSCREEN : (write ? SQUARE : (go ? LOAD_X_WAIT : LOAD_Y));
			LOAD_Y: next_state = blackscreen ? BLACKSCREEN : (write ? SQUARE : (go ? LOAD_Y_WAIT : LOAD_Y));
			LOAD_Y_WAIT: next_state = blackscreen ? BLACKSCREEN : (write ? SQUARE : (go ? LOAD_Y_WAIT : LOAD_X));
			SQUARE: next_state = ~square_done ? SQUARE : LOAD_X;
			BLACKSCREEN: next_state = ~blackscreen_done ? BLACKSCREEN : LOAD_X;
			default:next_state = LOAD_X;
		endcase
	end // state_table
	
	always @(*)
	begin: enable_signals
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_colour = 1'b1;
		square_counter_enable = 1'b0;
		blackscreen_counter_enable = 1'b0;
		writeEn = 1'b0;
		sel_xy_out = 1'b0;
		sel_colour = 1'b0;
		case (current_state)
			LOAD_X: begin
				ld_x = 1'b1;
				end
			LOAD_Y: begin
				ld_y = 1'b1;
				end
			SQUARE: begin
				writeEn = 1'b1;
				square_counter_enable = 1'b1;
			end
			BLACKSCREEN: begin
				writeEn = 1'b1;
				blackscreen_counter_enable = 1'b1;
				sel_xy_out = 1'b1;
				sel_colour = 1'b1;
			end
		endcase
	end // enable_signals
	
	always@(posedge CLOCK_50)
		begin: state_FFs
		if(!resetn)
			current_state <= LOAD_X;
		else
			current_state <= next_state;
	end // state_FFS

endmodule

module datapath(CLOCK_50, resetn, ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, inputSW, xy, colour, square_counter_enable, blackscreen_counter_enable, square_done, blackscreen_done, writeEn);

	input CLOCK_50, resetn, ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, square_counter_enable, blackscreen_counter_enable, writeEn;
	input [9:0] inputSW;
	output [14:0] xy;
	output [2:0] colour;
	output square_done, blackscreen_done;
	
	reg [7:0] x_reg;
	reg [6:0] y_reg;
	reg [2:0] colour, colour_reg;
	reg [14:0] xy, temp_xy;
	
	reg [4:0] squareCounter;
	reg [15:0] blackscreenCounter;
	reg square_done, blackscreen_done;
	
	always@(posedge CLOCK_50) begin
		if(!resetn) begin
			x_reg <= 8'b0;
			y_reg <= 7'b0;
			colour_reg <= 3'b0;
		end
		else begin
			if(ld_x)
				x_reg <= {1'b0, inputSW[6:0]};
			if(ld_y) begin
				if (inputSW[6:0] >= 7'd120)
					y_reg <= 7'd120;
				else
					y_reg <= inputSW[6:0];
			end
			if(ld_colour)
				colour_reg <= inputSW[9:7];
		end
	end
	
	always @(posedge CLOCK_50) begin
		if (!resetn) begin
			squareCounter <= 5'b00000;
		end
		else if (squareCounter == 5'b10000) begin
			squareCounter <= 5'b00000;
		end
		else if (square_counter_enable) begin
			squareCounter <= squareCounter + 1'b1;
		end
	end
	
	always @(posedge CLOCK_50) begin
		if (!resetn) begin
			blackscreenCounter <= 16'b0;
		end
		else if (blackscreenCounter == 16'b1000000000000000) begin
			blackscreenCounter <= 16'b0;
		end
		else if (blackscreen_counter_enable) begin
			blackscreenCounter <= blackscreenCounter + 1'b1;
		end
	end
	
	always @(*)
		begin : ALU
			// alu
			case (squareCounter)
				5'b00000: begin
					temp_xy = {{x_reg}, {y_reg}};
				end
				5'b00001: begin
					temp_xy = {{x_reg}, {y_reg + 2'b01}};
				end
				5'b00010: begin
					temp_xy = {{x_reg}, {y_reg + 2'b10}};
				end
				5'b00011: begin
					temp_xy = {{x_reg}, {y_reg + 2'b11}};
				end
				5'b00100: begin
					temp_xy = {{x_reg + 2'b01}, {y_reg}};
				end
				5'b00101: begin
					temp_xy = {{x_reg + 2'b01}, {y_reg + 2'b01}};
				end
				5'b00110: begin
					temp_xy = {{x_reg + 2'b01}, {y_reg + 2'b10}};
				end
				5'b00111: begin
					temp_xy = {{x_reg + 2'b01}, {y_reg + 2'b11}};
				end
				5'b01000: begin
					temp_xy = {{x_reg + 2'b10}, {y_reg}};
				end
				5'b01001: begin
					temp_xy = {{x_reg + 2'b10}, {y_reg + 2'b01}};
				end
				5'b01010: begin
					temp_xy = {{x_reg + 2'b10}, {y_reg + 2'b10}};
				end
				5'b01011: begin
					temp_xy = {{x_reg + 2'b10}, {y_reg + 2'b11}};
				end
				5'b01100: begin
					temp_xy = {{x_reg + 2'b11}, {y_reg}};
				end
				5'b01101: begin
					temp_xy = {{x_reg + 2'b11}, {y_reg + 2'b01}};
				end
				5'b01110: begin
					temp_xy = {{x_reg + 2'b11}, {y_reg + 2'b10}};
				end
				5'b01111: begin
					temp_xy = {{x_reg + 2'b11}, {y_reg + 2'b11}};
				end
				default: temp_xy = 15'b0;
			endcase
	end

	always @(*) begin
		if (!resetn) begin
			square_done = 1'b0;
			blackscreen_done = 1'b0;
		end
		else begin
			square_done = (squareCounter == 5'b10000);
			blackscreen_done = (blackscreenCounter == 16'b1000000000000000);
		end
	end
 
	// Output result register
	always@(posedge CLOCK_50) begin
		if(!resetn) begin
			xy <= 15'b0; 
			colour <= 3'b000; 
		end
		else begin
			if (sel_xy_out) 
				xy <= blackscreenCounter[14:0];
			if (!sel_xy_out)
				xy <= temp_xy;
			if (sel_colour)
				colour <= 3'b000;
			if (!sel_colour)
				colour <= colour_reg;
		end
	end

endmodule


