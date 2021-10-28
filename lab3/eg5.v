module REG4(
    input clk,rst_n,
    input [3:0] D_IN,
    output reg [3:0] D_OUT
);
    always@(posedge clk)
    begin
        if(rst_n==0)
            D_OUT<=4'b0;
        else
            D_OUT<=D_IN;
    end
endmodule
