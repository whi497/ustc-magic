module top_module (
    input clk,D,ret,re_n,
    output reg q
);
    wire temp1,temp2;
    select select1(.a(0),.b(1),.cout(temp1));
    select select2(.a(D),.b(temp1),.cout(temp2));
    always@(posedge clk)
    begin
        q<=temp2;
    end
endmodule

module selsct (     //二选一模块
    input a,b,sel,
    output cout
);
    wire s,carry1,carry2;
    not(s,sel);
    and(carry1,s,a);
    and(carry2,sel,b);
    or(cout,carry1,carry2);
endmodule