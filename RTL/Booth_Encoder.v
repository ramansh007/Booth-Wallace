// BOOTH ENCODER
`timescale 1ns / 1ps


module Booth_Encoder(input [2:0] multiplicand,
                     input [7:0]A_ff , 
                     output [8:0]PP ,
                     output reg sign);
   
    reg [8:0]PP_temp;
    always@(*) begin
        case(multiplicand)
            3'b000: begin PP_temp = 9'b0; sign = 0; end
            3'b001: begin PP_temp = {A_ff[7] , A_ff}; sign = 0; end
            3'b010: begin PP_temp = {A_ff[7] , A_ff}; sign = 0; end
            3'b011: begin PP_temp = {A_ff , 1'b0}; sign = 0; end
            3'b100: begin PP_temp = {~A_ff, 1'b1}; sign = 1; end
            3'b101: begin PP_temp = {~A_ff[7] , ~A_ff}; sign = 1; end
            3'b110: begin PP_temp = {~A_ff[7] , ~A_ff}; sign = 1; end
            3'b111: begin PP_temp = 9'b0; sign = 0; end
        endcase
    end       
    
    assign PP = PP_temp;                                                         
endmodule