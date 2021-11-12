`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/11 17:19:38
// Design Name: 
// Module Name: test_bench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module trancode (
    input [3:0] A,
    input _E1,_E2,E3,
    output reg [7:0] _Y
);
   always@(*)
   begin
       if(E3==1'b0||_E2==1'b1||_E1==1'b1)
        _Y=8'b1111_1111;
       else
       begin
        case(A)
        3'h7:_Y=8'b0111_1111;
        3'h6:_Y=8'b1011_1111;
        3'h5:_Y=8'b1101_1111;
        3'h4:_Y=8'b1110_1111; 
        3'h3:_Y=8'b1111_0111;
        3'h2:_Y=8'b1111_1011;
        3'h1:_Y=8'b1111_1101;
        3'h0:_Y=8'b1111_1110;
        default:_Y=8'b1;
        endcase
       end     
   end 
endmodule