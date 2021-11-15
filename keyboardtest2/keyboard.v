module keyboard(
	input CLOCK_50,
	output [9:0] LEDR,
   input    PS2_DAT, // PS2 data line
   input    PS2_CLK, // PS2 clock line
	input [9:9] SW
	);
	
	wire [7:0] codeDummy;
	wire [3:0] moveDummy;
	wire validDummy;
	wire makeBreakDummy;
	
	wire [2:0] Right_num;
	wire [2:0] Left_num;
	wire RShift;
	wire space;
	wire enter;
	
	keyboard_press_driver u0(
		.CLOCK_50(CLOCK_50),
		.valid(validDummy),
		.makeBreak(makeBreakDummy),
		.outCode(codeDummy),
//		.KEYBOARD_RESET(LEDR[9]),
//		.sig_move(LEDR[3:0]),///////////////////////////////////////////////////
		.KP_num(KP_num),
		.Left_num(Left_num),
		.RShift(RShift),
		.space(space),
		.enter(enter),
		.PS2_DAT(PS2_DAT),
		.PS2_CLK(PS2_CLK),
		.reset(SW[9])
	);
	
	assign LEDR[2:0] = Right_num;
	assign LEDR[5:3] = LEFT_num;
	assign LEDR[6] = RShift;
	assign LEDR[7] = space;
	assign LEDR[8] = enter;
	
endmodule

module keyboard_press_driver(
  input  CLOCK_50, 
  output reg valid, makeBreak,
  output reg [7:0] outCode,
//  output reg [3:0] sig_move,
//  output reg KEYBOARD_RESET,
  output reg [2:0] Right_num,
  output reg [2:0] Left_num,
  output reg RShift,
  output reg space,
  output reg enter,
  input    PS2_DAT, // PS2 data line
  input    PS2_CLK, // PS2 clock line
  input reset
);

	parameter FIRST = 1'b0, SEENF0 = 1'b1;
	reg state;
	reg [1:0] count;
	wire [7:0] scan_code;
	reg [7:0] filter_scan;
	wire scan_ready;
	reg read;
	parameter NULL = 8'h00;
	
	parameter [7:0] RIGHT1 = 8'h69;
	parameter [7:0] RIGHT2 = 8'h72;
	parameter [7:0] RIGHT3 = 8'h7A;
	parameter [7:0] ENTER = 8'h5A;
	parameter [7:0] SPACEBAR = 8'h29;
	parameter [7:0] LEFT1 = 8'h16;
	parameter [7:0] LEFT2 = 8'h1E;
	parameter [7:0] LEFT3 = 8'h26;
	parameter [7:0] RSHIFT = 8'h59;
	
	always @ (posedge CLOCK_50) begin
		Right_num <= 3'b0;
		Left_num <= 3'b0;
		space <= 1'b0;
		RShift <= 1'b0;
		enter <= 1'b0;
		if (outCode == KP1)
			Right_num[1] <= 1'b1 & makeBreak;
		if (outCode == KP2)
			Right_num[2] <= 1'b1 & makeBreak;
		if (outCode == KP3)
			Right_num[3] <= 1'b1 & makeBreak;
		if (outCode == LEFT1)
			Left_num[1] <= 1'b1 & makeBreak;
		if (outCode == LEFT2)
			Left_num[2] <= 1'b1 & makeBreak;
		if (outCode == LEFT3)
			Left_num[3] <= 1'b1 & makeBreak;
		if (outCode == RSHIFT)
			RShift <= 1'b1 & makeBreak;
		if (outCode == SPACEBAR)
			space <= 1'b1 & makeBreak;
		if (outCode == ENTER)
			enter <= 1'b1 & makeBreak;
	end
	
	initial 
	begin
		state = FIRST;
		filter_scan = NULL;
		read = 1'b0;
		count = 2'b00;
	end
		

	// inner driver that handles the PS2 keyboard protocol
	// outputs a scan_ready signal accompanied with a new scan_code
	keyboard_inner_driver kbd(
	  .keyboard_clk(PS2_CLK),
	  .keyboard_data(PS2_DAT),
	  .clock50(CLOCK_50),
	  .reset(reset),
	  .read(read),
	  .scan_ready(scan_ready),
	  .scan_code(scan_code)
	);

	always @(posedge CLOCK_50) begin
		case(count)
			2'b00:
				if(scan_ready)
					count <= 2'b01;
			2'b01:
				if(scan_ready)
					count <= 2'b10;
			2'b10:
				begin
					read <= 1'b1;
					count <= 2'b11;
					valid <= 0;
					outCode <= scan_code;
					case(state)
						FIRST:
							case(scan_code)
								8'hF0:
									begin
										state <= SEENF0;
									end
								8'hE0:
									begin
										state <= FIRST;
									end
								default:
									begin
										filter_scan <= scan_code;
										if(filter_scan != scan_code)
											begin
												valid <= 1'b1;
												makeBreak <= 1'b1;
											end
									end
							endcase
						SEENF0:
							begin
								state <= FIRST;
								if(filter_scan == scan_code)
									begin
										filter_scan <= NULL;
									end
								valid <= 1'b1;
								makeBreak <= 1'b0;
							end
					endcase
				end
			2'b11:
				begin
					read <= 1'b0;
					count <= 2'b00;
					valid <= 0;
				end
		endcase
	end
	
endmodule 

module keyboard_inner_driver(keyboard_clk, keyboard_data, clock50, reset, read, scan_ready, scan_code);
	input keyboard_clk;
	input keyboard_data;
	input clock50; // 50 Mhz system clock
	input reset;
	input read;
	output scan_ready;
	output [7:0] scan_code;
	reg ready_set;
	reg [7:0] scan_code;
	reg scan_ready;
	reg read_char;
	reg clock; // 25 Mhz internal clock

	reg [3:0] incnt;
	reg [8:0] shiftin;

	reg [7:0] filter;
	reg keyboard_clk_filtered;

	// scan_ready is set to 1 when scan_code is available.
	// user should set read to 1 and then to 0 to clear scan_ready

	always @ (posedge ready_set or posedge read)
	if (read == 1) scan_ready <= 0;
	else scan_ready <= 1;

	// divide-by-two 50MHz to 25MHz
	always @(posedge clock50)
		 clock <= ~clock;



	// This process filters the raw clock signal coming from the keyboard 
	// using an eight-bit shift register and two AND gates

	always @(posedge clock)
	begin
		filter <= {keyboard_clk, filter[7:1]};
		if (filter==8'b1111_1111) keyboard_clk_filtered <= 1;
		else if (filter==8'b0000_0000) keyboard_clk_filtered <= 0;
	end


	// This process reads in serial data coming from the terminal

	always @(posedge keyboard_clk_filtered)
	begin
		if (reset==1)
		begin
			incnt <= 4'b0000;
			read_char <= 0;
		end
		else if (keyboard_data==0 && read_char==0)
		begin
		 read_char <= 1;
		 ready_set <= 0;
		end
		else
		begin
			 // shift in next 8 data bits to assemble a scan code    
			 if (read_char == 1)
				  begin
					  if (incnt < 9) 
					  begin
						 incnt <= incnt + 1'b1;
						 shiftin = { keyboard_data, shiftin[8:1]};
						 ready_set <= 0;
					end
			  else
					begin
						 incnt <= 0;
						 scan_code <= shiftin[7:0];
						 read_char <= 0;
						 ready_set <= 1;
					end
			  end
		 end
	end

endmodule


