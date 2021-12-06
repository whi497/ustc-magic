module counter (
    input clk,button,
    input [2:0] sw,
    output [3:0] out
);
    wire button_n;
    reg enable;
    reg [3:0] cout;
    reg [7:0] result;
    jtrclr clr(.clk(clk),.button(button),.button_n(button_n));
    always@(posedge clk or posedge sw[1])                     
    begin
        if(sw[1])
        begin
            cout<=4'b0;
            enable<=1'b0;
        end
        else
        begin
            if(cout>=4'd9)
            cout<=4'b0;
            else cout=cout+4'b1;
            enable<=enable+1'b1;
        end
    end
    assign pulse_10Mhz=(cout==4'd9);
    always@(posedge clk or posedge sw[1])
    begin
        if(sw[1])
        begin
            result<=8'h1f;
        end
        else
        begin
            if(button_n)
            begin
                if(sw[0]) result<=result+8'b1;
                else result<=result-8'b1;
            end
        end
    end
endmodule

module jtrclr (
    input clk,button,
    output button_n
);
    reg [3:0] cnt;
    always@(posedge clk)
    begin
        if(button==1'b0) cnt<=4'h0;
        else if(cnt<4'h8)cnt<=cnt+4'b1;
    end
    assign button_n=cnt[3];
endmodule