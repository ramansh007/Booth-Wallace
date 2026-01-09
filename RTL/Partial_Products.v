// PARTIAL PRODUCTS GENERATOR
`timescale 1ns / 1ps


module Partial_Products(input [7:0] A_ff,
                        input [7:0] B_ff,
                        output [8:0] PP1,
                        output [8:0] PP2,
                        output [8:0] PP3,
                        output [8:0] PP4,
                        output [3:0] sign);

    wire [8:0] multiplicand;
    assign multiplicand = { B_ff , 1'b0};     
    
    Booth_Encoder Boothencode_1(.multiplicand(multiplicand[2:0]) , .A_ff(A_ff) , .PP(PP1) , .sign(sign[0]));
    Booth_Encoder Boothencode_2(.multiplicand(multiplicand[4:2]) , .A_ff(A_ff) , .PP(PP2) , .sign(sign[1]));
    Booth_Encoder Boothencode_3(.multiplicand(multiplicand[6:4]) , .A_ff(A_ff) , .PP(PP3) , .sign(sign[2]));
    Booth_Encoder Boothencode_4(.multiplicand(multiplicand[8:6]) , .A_ff(A_ff) , .PP(PP4) , .sign(sign[3]));                     
                
                    
endmodule