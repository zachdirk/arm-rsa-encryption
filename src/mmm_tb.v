`include "mmm.v"

module test;
    reg [63:0] X;
    reg [63:0] Y;
    reg [63:0] M;
    reg [31:0] m;
    wire [63:0] Z;
    
	mmm mont_mult(X,Y,M,m,Z);
	initial begin
        #300 X = 863;
        #300 Y = 741;
        #300 M = 3233;
        #300 m = 12;
        #300;
		$display("Z: %d", Z); //should output 741
    end
endmodule