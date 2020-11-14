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

	part2 p0(SW, LEDR);
	
endmodule


module part2(SW,LEDR);
		input [9:0]SW;
		output [9:0]LEDR;
		
		wire notS, w1, w2;
		
		v7404 u0(.pin1(SW[9]), .pin2(notS));
		v7408 u1(.pin1(SW[0]), .pin2(notS), .pin3(w1));
		v7408 u2(.pin4(notS), .pin5(SW[1]), .pin6(w2));
		v7432 u3(.pin1(w1), .pin2(w2), .pin3(LEDR[0]));
endmodule


module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13,
				  output pin2, pin4, pin6, pin8, pin10, pin12);
		assign pin2 = ~pin1;
		assign pin4 = ~pin3;
		assign pin6 = ~pin5;
		assign pin8 = ~pin9;
		assign pin10 = ~pin11;
		assign pin12 = ~pin13;
endmodule

module v7408(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				 output pin3, pin6, pin8, pin11);
		 assign pin3 = pin1 & pin2;
		 assign pin6 = pin4 & pin5;
		 assign pin8 = pin9 & pin10;
		 assign pin11 = pin12 & pin13;
endmodule

module v7432(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				 output pin3, pin6, pin8, pin11);
		 assign pin3 = pin1 | pin2;
		 assign pin6 = pin4 | pin5;
		 assign pin8 = pin9 | pin10;
		 assign pin11 = pin12 | pin13;
endmodule
