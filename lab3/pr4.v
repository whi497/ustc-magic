module top_module (
    input clk,
    output reg [4:0] Q
);
  wire [2:1] Qselect;
  wire [2:1] selout;
  wire clk_n,t1,t2,t3,rst;
  assign t1=~Q[0];
  and(t2,~Q[0],~Q[1]);
  assign clk_n=~clk;
  and (t3,~Q[0],~Q[1],~Q[2]);
  T_ff FF0(.clk(clk_n),.t(1),.cout(Q[0]));
  T_ff FF1(.clk(clk_n),.t(selout[1]),.cout(Q[1]));
  T_ff FF2(.clk(clk_n),.t(selout[2]),.cout(Q[2]));
  T_ff FF3(.clk(clk_n),.t(t3),.cout(Q[3]));
  selsct sel1(.cout(selout[1]),.a(t1),.b(0),.sel(rst));
  selsct sel2(.cout(selout[2]),.a(t2),.b(0),.sel(rst)); 
endmodule

module selsct (
    input a,b,sel,
    output cout
);
    wire s,carry1,carry2;
    not(s,sel);
    and(carry1,s,a);
    and(carry2,sel,b);
    or(cout,carry1,carry2);
endmodule

module T_ff (
    input clk,t,
    output reg cout
);
  always @(negedge clk) 
  begin
      if(t==1)
       cout<=~cout;
  end  
endmodule