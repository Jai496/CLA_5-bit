`timescale 1ns/1ps
module cla5_manchester (
    input  wire [4:0] A,
    input  wire [4:0] B,
    input  wire       Cin,      
    output wire [4:0] S,        
    output wire       Cout      
);
    wire [4:0] P;
    wire [4:0] G;
    wire [4:0] C; 

    assign P = A ^ B;
    assign G = A & B;

    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);
    assign Cout  = G[4] | (P[4] & C[4]); 

    assign S = P ^ C;

endmodule
