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

	part3 pO(SW, HEX0);
	
endmodule

module part3(SW, HEXO);
		input [9:0]SW;
		output [6:0]HEXO;
		
		hexdisplay u0(.c0(SW[0]), .c1(SW[1]), .c2(SW[2]), .c3(SW[3]), .S0(HEXO[0]), .S1(HEXO[1]),
						  .S2(HEXO[2]), .S3(HEXO[3]), .S4(HEXO[4]), .S5(HEXO[5]), .S6(HEXO[6]));
		
endmodule

module hexdisplay(input c0, c1, c2, c3, output S0, S1, S2, S3, S4, S5, S6);
		assign S0 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (c3 &
							~c2 & c1 & c0) | (c3 & c2 & ~c1 & c0);
		assign S1 = (~c3 & c2 & ~c1 & c0) | (~c3 & c2 & c1 & ~c0) | (c3 &
							~c2 & c1 & c0) | (c3 & c2 & ~c1 & ~c0) | (c3 & c2 & c1 & ~c0) | (c3 &
							c2 & c1 & c0);
		assign S2 = (~c3 & ~c2 & c1 & ~c0) | (c3 & c2 & ~c1 & ~c0) | (c3 &
							c2 & c1 & ~c0) | (c3 & c2 & c1 & c0);
		assign S3 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (~c3
							& c2 & c1 & c0) | (c3 & ~c2 & ~c1 & c0) | (c3 & ~c2 & c1 & ~c0) | (c3
							& c2 & c1 & c0);
		assign S4 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & ~c2 & c1 & c0) | (~c3 &
							c2 & ~c1 & ~c0) | (~c3 & c2 & ~c1 & c0) | (~c3 & c2 & c1 & c0) | (c3 &
							~c2 & ~c1 & c0);
		assign S5 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & ~c2 & c1 & ~c0) | (~c3
							& ~c2 & c1 & c0) | (~c3 & c2 & c1 & c0) | (c3 & c2 & ~c1 & c0);
		assign S6 = (~c3 & ~c2 & ~c1 & ~c0) | (~c3 & ~c2 & ~c1 & c0) | (~c3
							& c2 & c1 & c0) | (c3 & c2 & ~c1 & ~c0);
endmodule	



