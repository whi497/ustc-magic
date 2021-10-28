module RGE4 (
    input clk,rst_n,
    output reg [3:0] CNT
);
    always@(posedge clk)
    begin 
        if(rst_n==0)
            CNT<=4'b0;
        else
            CNT<=CNT+4'b1;
    end
endmodule