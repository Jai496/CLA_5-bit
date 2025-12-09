`timescale 1ns/1ps
module dff_tb;
    reg D;
    reg CLK;
    wire Q;

    dff_posedge uut (
        .d(D),
        .clk(CLK),
        .q(Q)
    );

    always #0.5 CLK = ~CLK;

    initial begin
        CLK = 0;
        D = 0;
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, dff_tb);

        #0.25 D = 1;  
        #1.00 D = 0; 
        #1.00 D = 1;
        #2.00 D = 0;

        #2.00 $finish;
    end

    initial begin
        $monitor("Time=%0t ns | CLK=%b D=%b | Q=%b", $time, CLK, D, Q);
    end

endmodule
