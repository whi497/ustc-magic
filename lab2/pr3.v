module selsct (
    input A,B,S,
    output cout,
);
    wire s,carry1,carry2,carry3,carry4;
    not(s,S);
    and(carry1,s,A);
    and(carry2,S,B);
    or(S,carry1,carry2);
endmodule

