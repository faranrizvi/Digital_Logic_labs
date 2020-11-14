module part2 (SW, CLOCK_50, HEX0); 

		input [9:0] SW;
		input CLOCK_50;
		output [6:0] HEX0;
		
		wire [4:0] disp_Count;
						
		speedController S1 (.f_Select(SW[1:0]), .clock(CLOCK_50), .reset(SW[9]), .countState(disp_Count));
		hexdisplay D1 (.C(disp_Count[3:0]), .HEX(HEX0));
						
endmodule 

module speedController (input [1:0] f_Select, input clock, reset, output [4:0] countState);

				wire [27:0] m_Cycles; 
				wire dwnClk_Enable; 
				
				speedSelect S1 (.select(f_Select), .maxCycles(m_Cycles));
				rateDivider R1 (.maxCycles(m_Cycles), .clock(clock), .reset(reset), .downClock(dwnClk_Enable));
				countUp C1 (.clock(clock), .reset(reset), .enable(dwnClk_Enable), .Q(countState));
				
endmodule 

module speedSelect (input [1:0] select, output reg [27:0] maxCycles);

				always @(*)
				begin
				
					case(select)
						2'b00: maxCycles = 28'b0000000000000000000000000001; //50MHz
						2'b01: maxCycles = 28'b0010111110101111000010000000; //1 Hz
						2'b10: maxCycles = 28'b0101111101011110000100000000; //0.5 Hz
						2'b11: maxCycles = 28'b1011111010111100001000000000; //0.25 Hz
						default: maxCycles = 28'b0000000000000000000000000001; //50Mhz
					endcase
				end

endmodule 

module rateDivider(input [27:0] maxCycles, input clock, reset, output downClock);
				
				reg [27:0] cycleCount;
				
				always @(posedge clock) 
				begin
				
					if (reset == 1'b1) 
						cycleCount <= 28'b0;						
					else if (cycleCount == 28'b0) 
						cycleCount <= maxCycles; 
					else
						cycleCount <= cycleCount - 1'b1; 
						
				end
				
				assign downClock = (cycleCount == 28'b0) ? (1'b1):(1'b0);

endmodule 


module countUp (input clock, reset, enable, output reg [4:0] Q);

				always @(posedge clock) 
				begin
				
					if (reset == 1'b0) 
						Q <= 5'b0;
					else if (Q == 5'b10000) 
						Q <= 5'b0;
					else if (enable == 1'b1) 
						Q <= Q + 1;
					else
						Q <= Q;
						
				end

endmodule 


module hexdisplay (input [3:0] C, output [6:0] HEX);

				
				assign HEX[0] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|!C[0]));
								
				assign HEX[1] = !((C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|C[0]) & 
								(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[2] = !((C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[3] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
								(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|C[2]|C[1]|!C[0]) & 
								(!C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[4] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|!C[0]) & 
								(C[3]|!C[2]|C[1]|C[0]) & (C[3]|!C[2]|C[1]|C[0]) &
								(C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) &
								(!C[3]|C[2]|C[1]|!C[0]));
								
				assign HEX[5] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|C[0]) & 
								(C[3]|C[2]|!C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) & 
								(!C[3]|!C[2]|C[1]|!C[0]));
								
				assign HEX[6] = !((C[3]|C[2]|C[1]|C[0]) & (C[3]|C[2]|C[1]|!C[0]) & 
								(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]));

endmodule


