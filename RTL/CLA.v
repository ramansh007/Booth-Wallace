// Carry Look Ahead Adder
`timescale 1ns / 1ps


module CLA (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] Sum
);

    wire [3:0] P_block, G_block; 
    wire [3:0] C_lookahead;      

    assign C_lookahead[0] = Cin;

    // Bits [3:0]
    cla_4bit cla0 (
        .a(A[3:0]), .b(B[3:0]), .cin(C_lookahead[0]), 
        .sum(Sum[3:0]), .p_group(P_block[0]), .g_group(G_block[0])
    );

    // Bits [7:4]
    cla_4bit cla1 (
        .a(A[7:4]), .b(B[7:4]), .cin(C_lookahead[1]), 
        .sum(Sum[7:4]), .p_group(P_block[1]), .g_group(G_block[1])
    );

    // Bits [11:8]
    cla_4bit cla2 (
        .a(A[11:8]), .b(B[11:8]), .cin(C_lookahead[2]), 
        .sum(Sum[11:8]), .p_group(P_block[2]), .g_group(G_block[2])
    );

    // Bits [15:12]
    cla_4bit cla3 (
        .a(A[15:12]), .b(B[15:12]), .cin(C_lookahead[3]), 
        .sum(Sum[15:12]), .p_group(P_block[3]), .g_group(G_block[3])
    );


    // --- LOOKAHEAD CARRY UNIT (LCU) LOGIC ---    
    assign C_lookahead[1] = G_block[0] | (P_block[0] & C_lookahead[0]);

    assign C_lookahead[2] = G_block[1] | (P_block[1] & G_block[0]) | 
                            (P_block[1] & P_block[0] & C_lookahead[0]);

    assign C_lookahead[3] = G_block[2] | (P_block[2] & G_block[1]) | 
                            (P_block[2] & P_block[1] & G_block[0]) | 
                            (P_block[2] & P_block[1] & P_block[0] & C_lookahead[0]);

//    // Calculate Cout (C16)
    assign Cout           = G_block[3] | (P_block[3] & G_block[2]) | 
                            (P_block[3] & P_block[2] & G_block[1]) | 
                            (P_block[3] & P_block[2] & P_block[1] & G_block[0]) | 
                            (P_block[3] & P_block[2] & P_block[1] & P_block[0] & C_lookahead[0]);

endmodule


module cla_4bit (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output p_group, 
    output g_group  
);

    wire [3:0] p, g; 
    wire [3:0] c;    

    assign p = a ^ b;
    assign g = a & b; 

    // 2. Calculate Lookahead Carries
    // C0 is cin
    assign c[0] = cin; 
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);

    assign sum = p ^ c;

    // 4. Calculate Block Propagate and Generate (for the next level)
    assign p_group = p[3] & p[2] & p[1] & p[0];     
    assign g_group = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule