/*
 * Propagate/Generate Logic Block (1-bit)
 * P = A XOR B (Propagate)
 * G = A AND B (Generate)
 */
module pg_block (
    input wire A,
    input wire B,
    output wire P, 
    output wire G  
);

    assign G = A & B;
    assign P = A ^ B;

endmodule