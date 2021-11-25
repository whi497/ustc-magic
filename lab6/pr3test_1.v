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

module testbench (
);
    reg clk,rst;
    wire [7:0] Q;
    conculator conculator(.clk(clk),.rst(rst),.Q(Q));
    initial begin
        rst=1;
        #5 rst=0;

    end
    initial begin
        clk=0;
        forever begin
            clk=~clk;
        end
    end
endmodule