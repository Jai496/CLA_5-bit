`timescale 1ns / 1ps

module pg_tb;
    reg A;
    reg B;
    wire P;
    wire G;
    pg_block uut (
        .A(A), 
        .B(B), 
        .P(P),
        .G(G)
    );

    initial begin
        $dumpfile("pg_tb.vcd");
        $dumpvars(0, pg_tb);
        A = 0; B = 0; 
        #10; 
        B = 1;
        #10; 
        A = 1; B = 0;
        #10; 
        B = 1;
        #10; 
        A = 0; B = 0;
        #10;
        $finish;
    end

    initial begin
        $monitor("Time=%t | A=%b B=%b | P=%b G=%b", $time, A, B, P, G);
    end

endmodule