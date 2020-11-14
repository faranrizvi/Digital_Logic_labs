`timescale 1ns / 1ps
`default_nettype none

module main	(
	input wire CLOCK_50,            //On Board 50 MHz
	input wire [9:0] SW,            // On board Switches
	input wire [3:0] KEY,           // On board push buttons
	output wire [6:0] HEX0,         // HEX displays
	output wire [6:0] HEX1,         
	output wire [6:0] HEX2,         
	output wire [6:0] HEX3,         
	output wire [6:0] HEX4,         
	output wire [6:0] HEX5,         
	output wire [9:0] LEDR,         // LEDs
	output wire [7:0] x,            // VGA pixel coordinates
	output wire [6:0] y,
	output wire [2:0] colour,       // VGA pixel colour (0-7)
	output wire plot,               // Pixel drawn when this is pulsed
	output wire vga_resetn          // VGA resets to black when this is pulsed (NOT CURRENTLY AVAILABLE)
);    

	lab5part3 p3(SW, KEY, LEDR, CLOCK_50);
	
endmodule

module part3(SW, KEY, LEDR, CLOCK_50);
    input [2:0]SW;
    input [1:0]KEY;
    input CLOCK_50;
    output reg [0:0]LEDR;

    wire enable; 
    wire [26:0] half_sec_timer = 27'b001011111010111100001000000; 
    reg [26:0] counter;
	 
    reg [12:0] seq; 
	 reg [12:0] shifted_seq;
    
    initial LEDR[0] <= 0;
    initial counter <= 0;
    initial seq <= 0;
    initial shifted_seq <= 0; 
    
    always@(SW)
        begin
            case(SW)
                3'b000: seq = 13'b1011100000000; //A
                3'b001: seq = 13'b1110101010000; //B
                3'b010: seq = 13'b1110101110100; //C
                3'b011: seq = 13'b1110101000000; //D
                3'b100: seq = 13'b1000000000000; //E
                3'b101: seq = 13'b1010111010000; //F
                3'b110: seq = 13'b1110111010000; //G
                3'b111: seq = 13'b1010101000000; //H
                default: seq = 13'b0;
            endcase
        end
	
    always@(posedge enable or negedge KEY[0] or negedge KEY[1]) 
        begin
		  
				if (KEY[0] == 1'b0)
					begin
						LEDR[0] <= 0;
						shifted_seq <= 13'b0000000000000;
					end
				else if (KEY[1] == 1'b0)
					shifted_seq <= seq;
					
				else if (enable == 1'b1)
					begin
						LEDR[0] <= shifted_seq[12];
						shifted_seq = shifted_seq << 1;
					end
        end
		  
    
    assign enable = (counter == 27'b0) ? 1'b1 : 1'b0;
    always@(posedge CLOCK_50)
        begin
            if (counter >= half_sec_timer)
                counter <= 27'b0;
            else
                counter <= counter + 1;
        end
endmodule

