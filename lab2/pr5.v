module preinfor (
    input [7:0] i,
    output [2:0] y
);
    assign y2=i[7] | i[6] | i[5] | i[4];
    assign y1=i[7] | i[6] | ~i[5]&~i[4]&i[3] | ~i[5]&~i[4]&i[2];
    assign y0=i[7] | ~i[6]&i[5] | ~i[6]&~i[4]&i[3] | ~i[6]&~i[4]&~i[2]&i[1];
endmodule