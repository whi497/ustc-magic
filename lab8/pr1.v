module test (
    input clk,rst,
    output led
);
    reg [1:0] cnt;
    reg [1:0] cnttemp;
    always@(*)
    begin
        cnttemp=cnt+2'b1;
    end
    always@(posedge clk or posedge rst)
    begin
        if(rst)cnt<=2'b0;
        else cnt<=cnttemp;
    end
    assign led=(cnt==2'b11)?1'b1:1'b0;
endmodule