`timescale 1ns/1ps
module cla5_comb_tb;
    reg [4:0] A;
    reg [4:0] B;
    reg       Cin;
    wire [4:0] S;
    wire       Cout;

    cla5_manchester uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    reg clk;
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cla5_comb_tb.vcd");
        $dumpvars(0, cla5_comb_tb);

        // Test 1: 0..40ns
        A = 5'b00011; B = 5'b00101; Cin = 1'b0;
        #40;

        // Test 2: 40..80ns
        A = 5'b11111; B = 5'b00111; Cin = 1'b0;
        #40;

        // Test 3: 80..120ns
        A = 5'b01010; B = 5'b01110; Cin = 1'b0;
        #40;

        // Test 4: 120..160ns
        A = 5'b11100; B = 5'b11100; Cin = 1'b1;
        #40;

        $display("COMBINATIONAL TB: finished at time %0t ns", $time);
        #10 $finish;
    end

    // Print S and Cout at regular intervals and when inputs change
    initial begin
        $display("Time(ns) |  A    B   Cin |   S    Cout ");
        $monitor("%8t | %b %b %b | %b %b", $time, A, B, Cin, S, Cout);
    end

endmodule
