`timescale 1ns/1ps

module cla5_pipelined (
    input  wire        clk,
    input  wire [4:0]  A_in,   
    input  wire [4:0]  B_in,    
    input  wire        Cin_in,  
    output wire [4:0]  S_out,   
    output wire        Cout_out  
);

    wire [4:0] A_reg;
    wire [4:0] B_reg;
    wire       Cin_reg;

    // Input Registers (Stage 1)
    genvar i;
    generate
        for (i=0; i<5; i=i+1) begin : gen_input_dffs_a
            dff_posedge dfa (.d(A_in[i]), .clk(clk), .q(A_reg[i]));
        end
        for (i=0; i<5; i=i+1) begin : gen_input_dffs_b
            dff_posedge dfb (.d(B_in[i]), .clk(clk), .q(B_reg[i]));
        end
    endgenerate

    dff_posedge dfc (.d(Cin_in), .clk(clk), .q(Cin_reg)); 

    // Combinational Logic (The Adder)
    wire [4:0] s_comb;
    wire       c_comb;
    
    cla5_manchester cla_inst (
        .A(A_reg),
        .B(B_reg),
        .Cin(Cin_reg),
        .S(s_comb),
        .Cout(c_comb)
    );

    // Output Registers (Stage 2)
    genvar j;
    generate
        for (j=0; j<5; j=j+1) begin : gen_output_dffs
            dff_posedge dfo (.d(s_comb[j]), .clk(clk), .q(S_out[j]));
        end
    endgenerate
    dff_posedge dfcout (.d(c_comb), .clk(clk), .q(Cout_out));

endmodule

// ============================================================
// MISSING MODULE 1: Positive Edge D Flip-Flop
// ============================================================
module dff_posedge (
    input wire d,
    input wire clk,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule

// ============================================================
// MISSING MODULE 2: 5-bit Manchester Adder (Logic Model)
// ============================================================
module cla5_manchester (
    input  wire [4:0] A,
    input  wire [4:0] B,
    input  wire       Cin,
    output wire [4:0] S,
    output wire       Cout
);
    // Carry Look-Ahead Logic
    wire [4:0] P, G;
    wire [5:0] C;

    // Propagate and Generate
    assign P = A ^ B; 
    assign G = A & B;

    // Carry Chain
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);
    assign C[5] = G[4] | (P[4] & C[4]);

    // Sum and Carry Out
    assign S = P ^ C[4:0];
    assign Cout = C[5];

endmodule