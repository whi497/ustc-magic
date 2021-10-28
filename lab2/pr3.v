module top_module(
    input a,b,c,d,sel1,sel2,
    output out
);
wire temp1,temp2;
selsct instance1(a,b,sel1,temp1);
selsct instance2(c,d,sel1,temp2);
selsct instance3(temp1,temp2,sel2,out);
endmodule

module selsct (
    input a,b,sel,
    output cout
);
    wire s,carry1,carry2,carry3,carry4;
    not(s,sel);
    and(carry1,s,a);
    and(carry2,sel,b);
    or(cout,carry1,carry2);
endmodule


