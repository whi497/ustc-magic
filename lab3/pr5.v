module D_rsth (
    input clk,D,rst,
    output reg q
);
    always @(posedge clk)
    begin
    if(rst==1)
        q=1'b0;
    else
        q=D;
    end
endmodule