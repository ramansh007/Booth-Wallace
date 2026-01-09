// D FLIP FLOP
`timescale 1ns / 1ps


module DFF( input clk , input reset ,
            input [7:0] A , input [7:0] B,
            output reg [7:0] A_ff , 
            output reg [7:0] B_ff 
            );
            
        always@(posedge clk or posedge reset) begin
            if(reset)begin
                A_ff <= 8'b0;
                B_ff <= 8'b0;
                end
            else begin
                A_ff <= A;
                B_ff <= B;
            end
         end               
endmodule   
