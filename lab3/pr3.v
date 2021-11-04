module top_module (
    input clk,reset,
    output Q0,Q1,Q2,Q3
);
  wire D0,D1,D2,D3;
  xor(D0,1,Q0);
  xor(D1,Q0,Q1);
  xor(D2,Q0&&Q1,Q2);
  xor(D3,Q0&&Q1&&Q2,Q3);
  noDchu FF0(.clk(clk),.D(D0),.rst(reset),.q(Q0));
  noDchu FF1(.clk(clk),.D(D1),.rst(reset),.q(Q1));
  noDchu FF2(.clk(clk),.D(D2),.rst(reset),.q(Q2));
  noDchu FF3(.clk(clk),.D(D3),.rst(reset),.q(Q3));
endmodule

module noDchu (//D触发器
    input clk,D,rst,
    output reg q
);
  always @(posedge clk or posedge rst) 
  begin
      if(rst==1)
      q<=0;
      else
      q<=D;
  end  
endmodule