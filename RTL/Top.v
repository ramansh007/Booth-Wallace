// TOP MODULE
`timescale 1ns / 1ps

module Top( clk , reset , A , B , Output);
    input clk;
    input reset;
    input [7:0] A;
    input [7:0] B;
    output reg [15:0] Output;
    
    wire [7:0] A_ff , B_ff;
    wire [8:0] PP1 ,PP2 ,PP3 ,PP4;
    wire [3:0] sign;
    wire [15:0] OUT;
    
    DFF D_ff(.clk(clk) , 
            .reset(reset) , 
            .A(A) , 
            .B(B)  ,
            .A_ff(A_ff) ,
            .B_ff(B_ff) );
        
    Partial_Products Gen_PP (
            .A_ff(A_ff),
            .B_ff(B_ff),
            .PP1(PP1),
            .PP2(PP2),
            .PP3(PP3),
            .PP4(PP4),
            .sign(sign)
        );
        
    Partial_Products_Adder Adder(.PP1(PP1) , 
            .PP2(PP2) , 
            .PP3(PP3) , 
            .PP4(PP4) , 
            .sign(sign) , 
            .out(OUT));
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            Output <= 16'b0;
        else
            Output <= OUT; 
    end
endmodule

