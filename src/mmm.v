module mmm(X, Y, M, m, Z);
    input wire [63:0] X;
    input wire [63:0] Y;
    input wire [63:0] M;
    input wire [31:0] m;
    
    reg Y_0 = 0;
    reg X_i = 0;
    reg Z_n = 0;
    integer i;
    output reg [63:0] Z = 0;
    
    always @(X, Y, M, m) begin
        for (i = 0; i < m; i = i+1) begin
            Y_0 = Y & 1;
            X_i = (X >> i) & 1;
            Z_n = (Z & 1) ^ (X_i & Y_0);
            Z = (Z + X_i*Y + Z_n*M) >> 1;
        end
        if (Z >= M) begin
            Z = Z - M;
        end
    end
endmodule