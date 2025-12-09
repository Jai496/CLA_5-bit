/*
 * Static D Flip-Flop (Positive Edge Triggered)
 * Author: Jai Srikar 2024102041
 */

module dff (
    input wire D,
    input wire CLK,
    output reg Q
);
    initial begin
        Q = 0;
    end

    always @(posedge CLK) begin
        Q <= D;
    end

endmodule