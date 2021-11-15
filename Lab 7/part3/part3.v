module part3
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
	input [0:0] KEY;
	input [9:7] SW;

	// To VGA
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	wire [14:0] xy;
	
	wire resetn;
	
	assign resetn = KEY[0];
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
		.inputSW(SW[9:7]),
		.xy(xy),
		.colour(colour),
		.writeEn(writeEn)
		);
	
endmodule

module handler(CLOCK_50, resetn, inputSW, xy, colour, writeEn);

	input CLOCK_50, resetn;
	input [2:0] inputSW;
	output [14:0] xy;
	output [2:0] colour;
	output writeEn;
	
	wire En_x_counter, En_y_counter, ld_colour, ld_direction;
	wire sel_colour, square_counter_enable, square_done;
	wire CLOCK_60HZ, UpdateFrame;
	
	control u1(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn),
		.En_x_counter(En_x_counter), 
		.En_y_counter(En_y_counter), 
		.ld_colour(ld_colour),
		.ld_direction(ld_direction),
		.sel_colour(sel_colour),
		.writeEn(writeEn),
		.square_counter_enable(square_counter_enable),
		.square_done(square_done),
		.UpdateFrame(UpdateFrame)
		);
	
	datapath u2(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn),
		.En_x_counter(En_x_counter), 
		.En_y_counter(En_y_counter),
		.ld_colour(ld_colour),
		.ld_direction(ld_direction),
		.sel_colour(sel_colour),
		.inputSW(inputSW), 
		.xy(xy),
		.colour(colour),
		.square_counter_enable(square_counter_enable),
		.square_done(square_done)
		);
		
		RateDivider_4HZ u5(
			.CLOCK_50(CLOCK_50), 
			.resetn(resetn), 
			.CLOCK_4HZ(UpdateFrame)
			);
		
//		RateDivider_60HZ u3(
//			.CLOCK_50(CLOCK_50), 
//			.resetn(resetn), 
//			.CLOCK_60HZ(CLOCK_60HZ)
//			);
//		
//		FrameCounter u4(
//			.CLOCK_50(CLOCK_50), 
//			.resetn(resetn), 
//			.CLOCK_60HZ(CLOCK_60HZ), 
//			.UpdateFrame(UpdateFrame)
//			);
	
endmodule

module RateDivider_4HZ(CLOCK_50, resetn, CLOCK_4HZ);

	input CLOCK_50, resetn;
	output CLOCK_4HZ;
	
	reg CLOCK_4HZ;
	reg [23:0] counter;

	always @(posedge CLOCK_50, negedge resetn) begin
		if (!resetn) begin
			counter <= 24'd0;
			CLOCK_4HZ <= 1'b0;
		end
		else begin
			counter <= (counter == 24'd12499999) ? 0 : counter + 1'b1;
			CLOCK_4HZ <= (counter == 24'd12499999);
		end
	end

endmodule

//module RateDivider_60HZ(CLOCK_50, resetn, CLOCK_60HZ);
//
//	input CLOCK_50, resetn;
//	output CLOCK_60HZ;
//	
//	reg CLOCK_60HZ;
//	reg [21:0] counter;
//
//	always @(posedge CLOCK_50, negedge resetn) begin
//		if (!resetn) begin
//			counter <= 22'd0;
//			CLOCK_60HZ <= 1'b0;
//		end
//		else begin
//			counter <= (counter == 22'd2499) ? 0 : counter + 1'b1;
//			CLOCK_60HZ <= (counter == 22'd2499) | (counter == 22'd833) | (counter == 22'd1666);
//		end
//	end
//
//endmodule
//
//module FrameCounter(CLOCK_50, resetn, CLOCK_60HZ, UpdateFrame);
//
//	input CLOCK_50, resetn, CLOCK_60HZ;
//	output UpdateFrame;
//	
//	reg UpdateFrame;
//	reg [3:0] counter;
//	
////	always @(posedge CLOCK_50) begin
////		if (!resetn) begin
////			counter <= 4'b0000;
////			UpdateFrame <= 1'b0;
////		end
////		else if (CLOCK_60HZ) begin
////			counter <= (counter == 4'd15) ? 0 : counter + 1'b1;
////			UpdateFrame <= (counter == 4'd15);
////		end
////	end
//	
//	always @(posedge CLOCK_60HZ, negedge resetn) begin
//		if (!resetn) begin
//			counter <= 4'b0000;
//			UpdateFrame <= 1'b0;
//		end
//		else if (counter == 4'b1110) begin
//			counter <= 4'b0000;
//			UpdateFrame <= 1'b1;
//		end
//		else begin
//			counter <= counter + 1'b1;
//			UpdateFrame <= 1'b0;
//		end
//	end
//
//endmodule

module control(CLOCK_50, resetn, En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, writeEn, square_counter_enable, square_done, UpdateFrame);

	input CLOCK_50, resetn, square_done, UpdateFrame;
	output En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, writeEn, square_counter_enable;
	
	reg En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, writeEn, square_counter_enable;
	
	reg [2:0] current_state, next_state; 
	
	localparam	INIT						= 3'b000,
					DRAW						= 3'b001,
					DRAW_WAIT				= 3'b010,
					ERASE						= 3'b011,
					UPDATE_COUNTER			= 3'b100,
					UPDATE_DIRECTION		= 3'b101;

// Next state logic aka our state table
	always@(*)
	begin:state_table 
		case (current_state)
			INIT: next_state = DRAW;
			DRAW: next_state = ~square_done ? DRAW : DRAW_WAIT;
			DRAW_WAIT: next_state = UpdateFrame ? ERASE : DRAW_WAIT;
			ERASE: next_state = ~square_done ? ERASE : UPDATE_COUNTER;
			UPDATE_COUNTER: next_state = UPDATE_DIRECTION;
			UPDATE_DIRECTION: next_state = DRAW;
			default:next_state = INIT;
		endcase
	end // state_table
	
	always @(*)
	begin: enable_signals
		En_x_counter = 1'b0;
		En_y_counter = 1'b0;
		ld_direction = 1'b0;
		ld_colour = 1'b1;
		square_counter_enable = 1'b0;
		writeEn = 1'b0;
		sel_colour = 1'b0;
		case (current_state)
			INIT: begin
			end
			DRAW: begin
				writeEn = 1'b1;
				square_counter_enable = 1'b1;
			end
			ERASE: begin
				writeEn = 1'b1;
				square_counter_enable = 1'b1;
				sel_colour = 1'b1;
			end
			UPDATE_COUNTER: begin
				En_x_counter = 1'b1;
				En_y_counter = 1'b1;
			end
			UPDATE_DIRECTION: begin
				ld_direction = 1'b1;
			end
		endcase
	end // enable_signals
	
	always@(posedge CLOCK_50)
		begin: state_FFs
		if (!resetn)
			current_state <= INIT;
		else
			current_state <= next_state;
	end // state_FFS

endmodule

module datapath(CLOCK_50, resetn, En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, inputSW, xy, colour, square_counter_enable, square_done);

	input CLOCK_50, resetn, En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, square_counter_enable;
	input [2:0] inputSW;
	output [14:0] xy;
	output [2:0] colour;
	output square_done;
	
	reg [7:0] x_reg;
	reg [6:0] y_reg;
	reg [2:0] colour, colour_reg;
	reg [14:0] xy, temp_xy;
	
	reg [4:0] squareCounter;
	reg square_done, Vertical_1_UP, Horizontal_1_LEFT;
	
	always@(posedge CLOCK_50) begin
		if (!resetn) begin
			x_reg <= 8'b0;
			y_reg <= 7'b0;
			colour_reg <= 3'b0;
			Vertical_1_UP <= 1'b0;
			Horizontal_1_LEFT <= 1'b0;
		end
		else begin
			if (En_x_counter) begin
				if (Horizontal_1_LEFT)
					x_reg <= x_reg - 1'b1;
				else
					x_reg <= x_reg + 1'b1;
			end
			if (En_y_counter) begin
				if (Vertical_1_UP)
					y_reg <= y_reg - 1'b1;
				else
					y_reg <= y_reg + 1'b1;
			end
			if (ld_colour)
				colour_reg <= inputSW;
			if (ld_direction) begin
				if (x_reg == 8'd0 || x_reg == 8'd160)
					Horizontal_1_LEFT <= ~Horizontal_1_LEFT;
				if (y_reg == 7'd0 || y_reg == 7'd120)
					Vertical_1_UP <= ~Vertical_1_UP;
			end
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
			if (!resetn)
				square_done = 1'b0;
			else
				square_done = (squareCounter == 5'b10000);
		end
 
	// Output result register
	always@(posedge CLOCK_50) begin
		if (!resetn) begin
			xy <= 15'b0; 
			colour <= 3'b000; 
		end
		else begin
			xy <= temp_xy;
			if (sel_colour)
				colour <= 3'b000;
			if (!sel_colour)
				colour <= colour_reg;
		end
	end

endmodule


