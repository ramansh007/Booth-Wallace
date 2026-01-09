// PARTIAL PRODUCTS ADDER
`timescale 1ns / 1ps


module Partial_Products_Adder( input [8:0] PP1 ,
                               input [8:0] PP2 ,
                               input [8:0] PP3 ,
                               input [8:0] PP4 ,
                               input [3:0] sign,
                               output [15:0] out);
    wire [11:0] p1;
    wire [10:0] p2;
    wire [10:0] p3;
    wire [9:0] p4;
    wire [15:0] row1 , row2;
    wire [30:1] S , C;

    // Sign Extention ELimination
    assign p1 = {~PP1[8] , PP1[8] , PP1[8] , PP1};
    assign p2 = {1'b1 , ~PP2[8] , PP2};
    assign p3 = {1'b1 , ~PP3[8] , PP3};
    assign p4 = {~PP4[8],PP4};
    
    ////////////////////    Wallace Tree    ////////////////////
    
    // Stage - 1
    Fa fa1(p1[2] , p2[0] , sign[1] , S[1] , C[1] );
    Fa fa2(p1[4] , p2[2] , p3[0] , S[2] , C[2] );
    Fa fa3(p1[5] , p2[3] , p3[1] , S[3] , C[3] );
    Fa fa4(p1[6] , p2[4] , p3[2] , S[4] , C[4] );
    Ha ha1(p4[0] , sign[3] , S[5] , C[5]);
    Fa fa5(p1[7] , p2[5] , p3[3] , S[6] , C[6] );
    Fa fa6(p1[8] , p2[6] , p3[4] , S[7] , C[7] );
    Fa fa7(p1[9] , p2[7] , p3[5] , S[8] , C[8] );
    Fa fa8(p1[10] , p2[8] , p3[6] , S[9] , C[9] );
    Fa fa9(p1[11] , p2[9] , p3[7] , S[10] , C[10] );
    Fa fa10(p2[10] , p3[8] , p4[6] , S[11] , C[11] );
    
    // Stage - 2
    Fa fa11(p1[3] , p2[1] , C[1] , S[12] , C[12]);
    Ha ha2(S[2] , sign[2] , S[13] , C[13]);
    Ha ha3(S[3] , C[2] , S[14] , C[14]);
    Fa fa12(S[4] , S[5] , C[3] , S[15] , C[15]);
    Fa fa13(S[6] , C[4] , C[5] , S[16] , C[16]);
    Fa fa14(S[7] , C[6] , p4[2] , S[17] , C[17]);
    Fa fa15(S[8] , C[7] , p4[3] , S[18] , C[18]);
    Fa fa16(S[9] , C[8] , p4[4] , S[19] , C[19]);
    Fa fa17(S[10] , C[9] , p4[5] , S[20] , C[20]);
    Ha ha4(S[11] , C[10] , S[21] , C[21]);
    Fa fa18(p3[9] , p4[7] , C[11] , S[22] , C[22]);
    
    // Stage - 3       
    Fa fa19(S[16] , C[15] , p4[1] , S[23] , C[23]);
    Ha ha5(S[17] , C[16] , S[24] , C[24]);
    Ha ha6(S[18] , C[17] , S[25] , C[25]);
    Ha ha7(S[19] , C[18] , S[26] , C[26]);
    Ha ha8(S[20] , C[19] , S[27] , C[27]);
    Ha ha9(S[21] , C[20] , S[28] , C[28]);
    Ha ha10(S[22] , C[21] , S[29] , C[29]);
    Fa fa20(p3[10] , p4[8] , C[22] , S[30] , C[30]);
    
    
    assign row1 = {p4[9] , S[30:23] , S[15:12] , S[1] , p1[1], p1[0]};
    assign row2 = {C[30:23] , 1'b0 , C[14:12] , 3'b0 , sign[0]};

//  assign out = row1 + row2;
    CLA cla_16_bit(.A(row1) , .B(row2) , .Cin(0) , .Sum(out));

endmodule   


// Full Adder and half Adder Modules
module Fa(input a , input b , input cin , output s , output cout);
    assign s = a^b^cin;
    assign cout = a&b | b&cin | cin&a;
endmodule  


module Ha (input  a,input  b,output s ,output cout);

    assign s  = a ^ b;
    assign cout = a & b;

endmodule       