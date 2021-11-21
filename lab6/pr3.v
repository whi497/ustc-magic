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
module conculator (
    input clk,rst,
    output [7:0] cout
);
    reg [29:0] Q;
    always @(posedge clk or posedge rst)
    begin
        if(rst==1)Q<=30'b0;
        else Q<=Q+30'b1;
    end
    assign cout=Q[29:22];
endmodule