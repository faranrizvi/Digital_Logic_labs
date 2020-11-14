module part2(SW, LEDR);

	input [9:0]SW;
	output [9:0]LEDR;
	
	rippleAdder r0(SW[7:4], SW[3:0], SW[8], LEDR[9], LEDR[3:0]);
	
endmodule

module rippleAdder(A, B, Cin, Cout, S);

	input [3:0]A, B;
	input Cin;
	output Cout;
	output [3:0]S;
	
	wire c1, c2, c3;
	
	fullAdder u0(A[0], B[0], Cin, c1, S[0]);
	fullAdder u1(A[1], B[1], c1, c2, S[1]);
	fullAdder u2(A[2], B[2], c2, c3, S[2]);
	fullAdder u3(A[3], B[3], c3, Cout, S[3]);
	
	
endmodule

module fullAdder(X, Y, Cinput, Coutput, Sum);

	input X, Y, Cinput;
	output Coutput, Sum;
	
	assign Coutput = (X & Y) | (Cinput & X) | (Cinput & Y);
	assign Sum = X ^ Y ^ Cinput;
endmodule

