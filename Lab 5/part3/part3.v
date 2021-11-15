`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(KEY, SW, Clock_50, LEDR);

	input [2:0] SW;
	input [1:0] KEY;
	input Clock_50;
	output [0:0] LEDR;
	
	wire [15:0] payload;
	
	wire Enable;
	wire toLEDR;
	
	//Sets payload for output
	//payload is 16 bit bitstream
	selCharacter sel0(
		.SW(SW[2:0]),
		.payload(payload)
	);
	
	//50MHz to 2Hz converter, Enable line is 1 for every 24,999,999th clock posedge to 25,000,000th clock posedge
	rateDivider rd0(
		.givenCLK(Clock_50),
		.Enable(Enable),
		.Reset_n(KEY[0])
	);
	
	//Left shifting register, direction corresponds to payload setting
	shiftReg_16b sr0(
		.payload(payload),
		.Clock(Clock_50),
		.Enable(Enable),
		.Reset_n(KEY[0]),
		.toLEDR(LEDR[0]),
		.userButton(KEY[1])
	);

endmodule

module shiftReg_16b(payload, Clock, Enable, Reset_n, toLEDR, userButton);

	input [15:0] payload;
	input Clock, Enable, Reset_n, userButton;
	output toLEDR;
	
	reg [15:0] register_16b;
	reg [3:0] counter;
	reg toLEDR, start;
	
	always @ (posedge Clock, negedge Reset_n)
	begin
		if(!Reset_n || counter >= 16)			//if we want to reset or if counter hits 16 (since 16 bit long bitstream), we reset
		begin
			register_16b <= payload;
			counter <= 4'b0000;
			start <= 1'b0;
		end
		else if (Enable && start)				//output will run first since we check for it first
		begin											//this means that only the first clock posedge with KEY[0] active(low) counts
			register_16b[0] <= 1'b0;
			register_16b[1] <= register_16b[0];
			register_16b[2] <= register_16b[1];
			register_16b[3] <= register_16b[2];
			register_16b[4] <= register_16b[3];
			register_16b[5] <= register_16b[4];
			register_16b[6] <= register_16b[5];
			register_16b[7] <= register_16b[6];
			register_16b[8] <= register_16b[7];
			register_16b[9] <= register_16b[8];
			register_16b[10] <= register_16b[9];
			register_16b[11] <= register_16b[10];
			register_16b[12] <= register_16b[11];
			register_16b[13] <= register_16b[12];
			register_16b[14] <= register_16b[13];
			register_16b[15] <= register_16b[14];
			toLEDR <= register_16b[15];
			counter <= counter + 1;
		end
		else if (!userButton)				//single click of KEY[0] probably covers lots of clock posedge's 
		begin										//doing it this way makes sure we don't double count
			register_16b <= payload;		//ready the regs for output process
			counter <= 4'b0000;
			start <= 1'b1;
		end
	end

endmodule

module rateDivider(givenCLK, Enable, Reset_n);

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
		else if(counter == 26'd2499) //output of 2Hz remember to change back to 25MHz //testing with 2.5KHz
		begin
			counter <= 26'd0;
			Enable = 1'b1;
		end
		else
		begin
			counter <= counter + 1;
			Enable <= 1'b0;
		end
	end

endmodule

module selCharacter(SW, payload);

	input [2:0] SW;
	output [15:0] payload;
	
	reg [15:0] payload;
	
	always @(*)
	begin
		if (SW[2:0] == 3'b000)
			payload <= 16'b1011100000000000; //A NOTE ROTATE OUT FROM LEFT REQUIRED!
		else if (SW[2:0] == 3'b001)
			payload <= 16'b1110101010000000; //B
		else if (SW[2:0] == 3'b010)
			payload <= 16'b1110101110100000; //C
		else if (SW[2:0] == 3'b011)
			payload <= 16'b1110101000000000; //D
		else if (SW[2:0] == 3'b100)
			payload <= 16'b1000000000000000; //E
		else if (SW[2:0] == 3'b101)
			payload <= 16'b1010111010000000; //F
		else if (SW[2:0] == 3'b110)
			payload <= 16'b1110111010000000; //G
		else if (SW[2:0] == 3'b111)
			payload <= 16'b1010101000000000; //H
		else 
			payload <= 16'b0000000000000000;
	end

endmodule
