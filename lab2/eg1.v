module test (
    input in,
    output out,
    output out_n,
);
    assign out=in;
    assign out_n=~in;
endmodule