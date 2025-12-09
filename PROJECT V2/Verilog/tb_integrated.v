`timescale 1ns/1ps
module cla5_pipelined_tb;
    reg clk;
    reg [4:0] A_in;
    reg [4:0] B_in;
    reg       Cin_in;

    wire [4:0] S_out;
    wire       Cout_out;

    cla5_pipelined dut (
        .clk(clk),
        .A_in(A_in),
        .B_in(B_in),
        .Cin_in(Cin_in),
        .S_out(S_out),
        .Cout_out(Cout_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cla5_pipelined_tb.vcd");
        $dumpvars(0, cla5_pipelined_tb);

        // initial test (0..40ns)
        A_in  = 5'b00011; B_in = 5'b00101; Cin_in = 1'b0;
        #40;

        // test 2 (40..80ns)
        A_in  = 5'b11111; B_in = 5'b00111; Cin_in = 1'b0;
        #40;

        // test 3 (80..120ns)
        A_in  = 5'b01010; B_in = 5'b01110; Cin_in = 1'b0;
        #40;

        // test 4 (120..160ns)
        A_in  = 5'b11100; B_in = 5'b11100; Cin_in = 1'b1;
        #40;

        $display("PIPELINED TB: finished at time %0t ns", $time);
        #20 $finish;
    end

    always @(posedge clk) begin
        #0; 
        $display("t=%0t ns : A_in=%b B_in=%b Cin=%b => S_out=%b Cout_out=%b", $time, A_in, B_in, Cin_in, S_out, Cout_out);
    end

    initial begin
        $display("Time(ns) | clk | A_in  B_in  Cin | S_out Cout_out");
        $monitor("%8t |  %b  | %b %b %b | %b %b", $time, clk, A_in, B_in, Cin_in, S_out, Cout_out);
    end

endmodule
