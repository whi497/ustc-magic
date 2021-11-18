module test(input clk,output reg a);
    always@(posedge clk)
        a<=a^1'b1;
endmodule