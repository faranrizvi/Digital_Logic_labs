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

	part3 p3(CLOCK_50, SW, x, y, colour, plot);
	
endmodule

module part3
    (
        CLOCK_50,                        
        SW,
		  x,
		  y,
		  colour,
		  plot,
		  //vga_resetn
    );

    input CLOCK_50;                
    input [9:0] SW;
	 output [7:0] x;
	 output [6:0] y;
	 output [2:0] colour;
	 output reg plot;
	 //output reg vga_resetn;
	 
    reg [2:0] clr = 3'b001;
    reg [6:0] xin = 7'd0;
    reg [6:0] yin = 7'd0;
    reg rx = 1'b0;
    reg ry = 1'b0;

    reg go = 1;
    wire erase;
    reg trigger = 1;
    reg reset = 1;
    reg clk = 1'b0;
    reg [7:0] erasecounter = 7'b0;
    assign erase = (erasecounter == 7'b0) ? 1'b0 : 1'b1;
    reg [3:0] speedcount;

    wire pulse; // 120Hz pulse generated for 1/120 period
    wire [26:0] timer = 27'b000000001100101101110011010; // 1/120 sec count (120Hz)
    reg [26:0] counter;
    
     // Generate 120Hz Pulse
    assign pulse = (counter == 27'b0) ? 1'b1 : 1'b0;
    always@(posedge CLOCK_50) begin
        if (counter >= timer)
            counter <= 27'b0;
        else
            counter <= counter + 1;
    end
    
    always @(posedge pulse) begin
        if (erasecounter >= 7'b11)
            erasecounter <= 7'b0;
        else
            erasecounter <= erasecounter + 1;
        
        speedcount <= speedcount + 1;

        clk = ~clk; // Generate 120Hz clk - eqv of 60 Hz refresh rate
        if (clk) begin // clk posedge set clr, update sprite x location
            
            case(rx)
                1'b0: begin
                    if (xin == 7'd124)
                        rx <= 1'b1;
                        
                    else if (speedcount >= SW[2:0])
                        xin <= xin + 7'd1;
                    end
                1'b1: begin
                    if (xin == 7'd0)
                        rx <= 1'b0;
                        
                    else if (speedcount >= SW[2:0])
                        xin <= xin - 7'd1;
                    end
                default: rx <= 1'b0;
            endcase

            case(ry)
                1'b0: begin
                    if (yin == 7'd116)
                        ry <= 1'b1;
                        
                    else if (speedcount >= SW[2:0])
                        yin <= yin + 7'd1;
                    end
                1'b1: begin
                    if (yin == 7'd0)
                        ry <= 1'b0;
                        
                    else if (speedcount >= SW[2:0])
                        yin <= yin - 7'd1;
                    end
                default: ry <= 1'b0;
            endcase
        
            go <= 1'b0;
            trigger <= 1'b1;
        end
        else begin
            // clk negedge update sprite y location and display

            go <= 1'b1;
            trigger <= 1'b0;
        end

        // + 7'b1 allows speedcount to be updated on the next cycle because how <= works vs. =
        if (speedcount >= (SW[2:0] + 7'b1))
            speedcount <= 4'b0;
    end

    wire Lx, Ly, Lc, enable;
    wire [2:0] DataColour;

    assign DataColour = clr;

    always @(*) begin
        case (~erase)
            1'b1: plot = 1'b1;
            1'b0: plot = ~trigger;
            default: plot = ~trigger;
        endcase
    end

    control C0(
        .clk(CLOCK_50),
        .resetn(reset),
        .plot(plot),
        .enable(enable),
        .go(~go),

        .lx(Lx), 
        .ly(Ly),
        .lc(Lc)
    );

    datapath D0(
        .clk(CLOCK_50),
        .resetn(reset),
        .plot(plot),
        .enable(enable),

        .lx(Lx), 
        .ly(Ly),
        .lc(Lc),
        .lb(~erase),
        .xin(xin),
        .yin(yin),
        .colour(DataColour),
        .cout(colour),
        .xout(x),
        .yout(y)
    );
endmodule

module control(clk, resetn, plot, enable, go, lx, ly, lc);

    input clk;
    input go;
    input resetn;
    input plot;
    output reg enable;
    output reg lx;
    output reg ly; 
    output reg lc;

    reg [3:0] current_state;
    reg [3:0] next_state;
       
    
    localparam  S_LOAD_X       = 3'd0,
                S_LOAD_WAIT_X  = 3'd1,
                S_LOAD_Y       = 3'd2,
                S_LOAD_WAIT_Y  = 3'd3,
                CYCLE_0        = 3'd4,
                S_DONE         = 3'd5;
                    
    always@(*)
    begin: state_table
            case (current_state)
                 S_LOAD_X: next_state = go ? S_LOAD_WAIT_X : S_LOAD_X;
                S_LOAD_WAIT_X: next_state = go ? S_LOAD_WAIT_X : S_LOAD_Y; 
                S_LOAD_Y: next_state = go ? S_LOAD_WAIT_Y : S_LOAD_Y;    
                S_LOAD_WAIT_Y: next_state = go ? S_LOAD_WAIT_Y : CYCLE_0; 
                CYCLE_0: next_state = S_DONE;
                S_DONE: next_state = S_LOAD_X;
                default: next_state = S_LOAD_X;
            endcase
    end
   
always @(*)
    begin: enable_signals
        // By default make all our signals 0
        lx = 1'b0;
        enable = 1'b0;
        lc = 1'b0;
        ly = 1'b0;
  
 
        case (current_state)
            S_LOAD_X: begin
                lx = 1'b1;
                lc = 1'b1;
                enable = 1'b0;    
                ly = 1'b0;
            end
                          
            S_LOAD_Y: begin
                lx = 1'b0;
                lc = 1'b0;
                enable = 1'b0;    
                ly = 1'b1;
            end
                          
            CYCLE_0: begin
                lx = 1'b0;
                lc = 1'b0;
                enable = 1'b1;    
                ly = 1'b0;
            end
                          
            S_DONE: begin
                lx = 1'b0;
                lc = 1'b0;
                enable = 1'b1;    
                ly = 1'b0;
            end
      endcase
    end
                    
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if (!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule 


module datapath(lx, ly, lc, lb, xin, yin, enable, plot, resetn, clk, xout, yout, colour, cout);

    input clk;
    input resetn;
    input plot;
    input enable;
    input lx;
    input ly; 
    input lc;
    input lb;

    input [2:0] colour;
    input [6:0] xin;
    input [6:0] yin;
    output reg [7:0] xout;
    output reg [6:0] yout;
    output reg [2:0] cout;

    reg [2:0] regcolour;
    reg [7:0] Xorigin;
    reg [6:0] Yorigin;
    reg [3:0] counter;
    reg [2:0] regBlack;
    reg [14:0] counterBlack;

    always@(posedge clk) begin
        if (!resetn) begin
            Xorigin <= 8'b0;
            Yorigin <= 7'b0;
            regcolour <= 3'b0;
        end
        else begin

            if (lx)
                Xorigin <= {1'b0, xin};
            if (ly)
                Yorigin <= yin;
            if (lc)
                regcolour <= colour;
        end
    end
        
    always@ (posedge clk) begin
        
        if (lb) begin
            counterBlack <= counterBlack + 1'b1;
            xout <= counterBlack[7:0];
            yout <= counterBlack[14:8];
            cout <= 3'b000;
        end
        else begin
            if (plot)
                begin
                    if (!resetn) begin

                        xout <= 8'b0;
                        yout <= 7'b0;
                        counter <= 4'b0;
                        cout <= 3'b0; 
                        counterBlack <= 15'b0;
                    end
                    if (counter <= 4'b1111) begin

                        counterBlack <= 15'b0;
                        cout <= regcolour  + 1'b0;
                        xout <= Xorigin + counter[1:0];
                        yout <= Yorigin + counter[3:2];
                        counter <= counter + 1'b1;
                    end
                    else begin
                        xout <= xout;
                        yout <= yout;
                        cout <= 3'b0;
                    end
                end
            else begin
                xout <= xout;
                yout <= yout;
            end
        end
    end
endmodule