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
  reg clk,RST_N,D;
  wire o;
  d_ff_r d_ff_r(.clk(clk),.rst_n(RST_N),.d(D),.q(o));
  initial begin
      clk=0;
      forever #5 clk=~clk;
  end 
  initial begin
      RST_N=0;D=0;
      #12.5 D=1;
      #10 RST_N=1;
      #5 D=0;
  end
endmodule