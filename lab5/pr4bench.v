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
   reg [3:0] A;
   reg _E1,_E2,E3;
   wire [7:0] _Y;
   integer i=0;
   trancode trancode(.A(A),._E1(_E1),._E2(_E2),.E3(E3),._Y(_Y));
   initial begin
       _E1=1;_E2=0; E3=1; A=3'h0;
       #10 _E1=0; _E2=1; E3=1; A={$random}%8;
       #10 _E1=0; _E2=0; E3=0; A={$random}%8;
       #10 _E1=0; _E2=0; E3=1; A={$random}%8;
       for(i=0;i<8;i=i+1)begin
           #10 A=i;
       end
       #10 $stop;
   end 
endmodule