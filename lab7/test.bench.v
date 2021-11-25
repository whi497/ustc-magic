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

module test_bench (
    
);
    integer i=0;
    reg [3:0] a;
    wire [7:0] spo;
    display display(.a(a),.spo(spo));
    initial begin
        a=0;
        for(i=0;i<16;i=i+1)begin
            #10 a=i;
        end
        #10$stop;
    end
endmodule