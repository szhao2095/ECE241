//Sw[7:0] data_in

//KEY[0] synchronous reset when pressed
//KEY[1] go signal

//LEDR displays result
//HEX0 & HEX1 also displays result

module part3(SW, KEY, CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [7:0] SW;
    input [1:0] KEY;
    input CLOCK_50;
    output [3:0] LEDR;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    wire resetn;
    wire go;
	 wire [8:0] A;
    wire [3:0] quotient, remainder;
	 wire [3:0] Divisor, Dividend;
	 
    assign go = ~KEY[1];
    assign resetn = KEY[0];
	 assign Divisor = SW[3:0];
	 assign Dividend = SW[7:4];
	 assign remainder = A[7:4];
	 assign quotient = A[3:0];
    assign LEDR[3:0] = quotient;

	 whereTheMagicHappens magic0(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn), 
		.go(go), 
		.Divisor(Divisor),
		.Dividend(Dividend), 
		.A(A)
		);
      

    hex_decoder H0(
        .hex_digit(Divisor), 
        .segments(HEX0)
        );
        
    hex_decoder H1(
        .hex_digit(4'b0000), 
        .segments(HEX1)
        );    
		  
	  hex_decoder H2(
        .hex_digit(Dividend), 
        .segments(HEX2)
        );
        
    hex_decoder H3(
        .hex_digit(4'b0000), 
        .segments(HEX3)
        );    
		  
	  hex_decoder H4(
        .hex_digit(quotient), 
        .segments(HEX4)
        );
        
    hex_decoder H5(
        .hex_digit(remainder), 
        .segments(HEX5)
        );

endmodule

module whereTheMagicHappens(CLOCK_50, resetn, go, Divisor, Dividend, A);

	input CLOCK_50, resetn, go;
	input [3:0] Divisor, Dividend;
	output [8:0] A;
	
	wire ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, new_A, new_Dividend, MSB_A;
	wire [1:0] alu_op;
	
	control control0(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn), 
		.go(go), 
		.MSB_A(MSB_A), 
		.ld_a(ld_a), 
		.ld_r(ld_r), 
		.ld_Dividend(ld_Dividend),
		.ld_Divisor(ld_Divisor), 
		.alu_select_a(alu_select_a), 
		.alu_op(alu_op), 
		.new_A(new_A), 
		.new_Dividend(new_Dividend)
		);
		
	datapath datapath0(
		.CLOCK_50(CLOCK_50), 
		.resetn(resetn), 
		.Divisor(Divisor), 
		.Dividend(Dividend), 
		.ld_a(ld_a), 
		.ld_r(ld_r), 
		.ld_Dividend(ld_Dividend), 
		.ld_Divisor(ld_Divisor), 
		.alu_select_a(alu_select_a), 
		.alu_op(alu_op), 
		.new_A(new_A), 
		.new_Dividend(new_Dividend), 
		.A(A),
		.MSB_A(MSB_A)
		);

endmodule

module control(CLOCK_50, resetn, go, MSB_A, ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, alu_op, new_A, new_Dividend);
	 
	 input CLOCK_50, resetn, go, MSB_A;
	 output ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, new_A, new_Dividend;
	 output [1:0] alu_op;
	 
	 reg ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, new_A, new_Dividend;
	 reg [3:0] counter;
	 reg [3:0] current_state, next_state;
	 reg [1:0] alu_op; 
    
    localparam  LoadingInValues         = 4'b0000,
					 LoadingInValues_Wait    = 4'b0001,
					 LeftShifting            = 4'b0010,
					 LeftShifting_Wait       = 4'b0011,
					 ASubDivisor             = 4'b0100,
					 ASubDivisor_Wait        = 4'b0101,
					 APlusDivisor            = 4'b0110,
					 APlusDivisor_Wait       = 4'b0111,
					 Output 						 = 4'b1000;
					 
	 // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
                LoadingInValues: begin
						 next_state = go ? LoadingInValues_Wait : LoadingInValues;
						 counter = 1'b0;
					 end
					 LoadingInValues_Wait: begin
						 next_state = go ? LoadingInValues_Wait : LeftShifting;
					 end
					 LeftShifting: begin
					    next_state = LeftShifting_Wait;
					 end
					 LeftShifting_Wait: begin
						 next_state = ASubDivisor;
					 end
					 ASubDivisor: begin
						 next_state = ASubDivisor_Wait;
					 end
					 ASubDivisor_Wait: begin
							 if (MSB_A) 
								  next_state = APlusDivisor;
							 else begin
								  if (counter >= 3) 
										next_state = Output;
								  else begin
										counter = counter + 1'b1;
										next_state = LeftShifting;
								  end
							 end
					 end
					 APlusDivisor: begin
						 next_state = APlusDivisor_Wait;
					 end
					 APlusDivisor_Wait: begin
							 if (counter >= 3) 
								  next_state = Output;
							 else begin
								  counter = counter + 1'b1;
								  next_state = LeftShifting;
							 end
					 end
					 Output: begin
						 next_state = LoadingInValues;
					 end
            default: next_state = LoadingInValues;
        endcase
    end // state_table
	 
	 
    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_a = 1'b0;
        ld_r = 1'b0;
        ld_Dividend = 1'b0;
        ld_Divisor = 1'b0;
        alu_select_a = 1'b0;
        alu_op = 2'b00;
        new_A = 1'b0;
        new_Dividend = 1'b0;

        case (current_state)
            LoadingInValues: begin
					 ld_a = 1'b1;
					 ld_Dividend = 1'b1;
					 ld_Divisor = 1'b1;
                end
            LeftShifting: begin
					 alu_select_a = 1'b0;
					 alu_op = 2'b01;
                end
            LeftShifting_Wait: begin
					 ld_a = 1'b1;
					 ld_Dividend = 1'b1;
					 new_A = 1'b1;
					 new_Dividend = 1'b1;
                end
            ASubDivisor: begin
					 alu_select_a = 1'b1;
					 alu_op = 2'b10;
                end
            ASubDivisor_Wait: begin
					 ld_a = 1'b1;
					 ld_Dividend = 1'b1;
					 new_A = 1'b1;
					 new_Dividend = 1'b1;
                end
            APlusDivisor: begin
					 alu_select_a = 1'b1;
					 alu_op = 2'b11;
                end
            APlusDivisor_Wait: begin
					 ld_a = 1'b1;
					 new_A = 1'b1;
					 end
				Output: begin
					 ld_r = 1'b1;
                end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
	 
	 // current_state registers
    always@(posedge CLOCK_50)
    begin: state_FFs
        if(!resetn)
            current_state <= LoadingInValues;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(CLOCK_50, resetn, Divisor, Dividend, ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, alu_op, new_A, new_Dividend, A, MSB_A);

	input CLOCK_50, resetn, ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, new_A, new_Dividend;
	input [1:0] alu_op;
	input [3:0] Divisor, Dividend;
	output MSB_A;
	output [8:0] A;
	
	reg [8:0] A, alu_out;
	reg [4:0] a_Reg;
   reg [3:0] alu_a, Dividend_Reg, Divisor_Reg;
	
	assign MSB_A = alu_out[8];
	
	always@(posedge CLOCK_50) begin
		if(!resetn) begin
			a_Reg <= 5'b0;
			Dividend_Reg <= 4'b0;
			Divisor_Reg <= 4'b0;
		end
		else begin
			if(ld_a)
				 a_Reg <= new_A ? alu_out[8:4] : 5'b00000;
			if(ld_Dividend)
				 Dividend_Reg <= new_Dividend ? alu_out[3:0] : Dividend;
			if(ld_Divisor)
				 Divisor_Reg <= Divisor;
		end
	end

	 // Output result register
    always@(posedge CLOCK_50) begin
        if(!resetn) begin
            A <= 9'b0; 
        end
        else 
            if(ld_r)
                A <= alu_out;
    end
	 
    // The ALU input multiplexers
    always @(*)
    begin
        case (alu_select_a)
            1'b0:
                alu_a = Dividend_Reg;
            1'b1:
                alu_a = Divisor_Reg;
            default: alu_a = 4'b0000;
        endcase
	 end

    // The ALU 
    always @(*)
    begin : ALU
        // alu
        case (alu_op)
            2'b01: begin
                   alu_out = {{a_Reg} , {alu_a}};
						 alu_out = alu_out << 1;
               end
            2'b10: begin
                   alu_out = {{a_Reg - alu_a} , {Dividend_Reg}};
						 alu_out[0] = ~alu_out[8];
               end
            2'b11: begin
						 alu_out= {{a_Reg + alu_a} , {Dividend_Reg}};
               end
            default: begin
					alu_out = alu_out;
				end
        endcase
    end
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule
