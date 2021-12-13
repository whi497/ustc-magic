module check (
    input clk,button,
    input [1:0] sw,
    output reg [2:0] selsct,
    output reg [3:0] outdisplay
);
    reg [3:0] cout;
    reg [3:0] outin;
    reg [15:0] outstate;
    reg [3:0] currentstate;
    reg [3:0] nextstate;
    reg [2:0] enable;
    wire clk_n;
    wire button_n;
    wire button_edge;
    //状态机状态
    parameter A = 4'ha;
    parameter B = 4'hb;
    parameter C = 4'hc;
    parameter D = 4'hd;
    //信号处理
    jtrclr clr(.clk(clk),.button(button),.button_n(button_n));
    signal_edge cedge(.clk(clk),.button(button_n),.button_edge(button_edge));
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(sw[1]),.locked(locked));
    //生成次态
    always@(*)
    begin
        if(button_edge)
        begin
            case(currentstate)
            A:
            begin
                if(sw[0]) nextstate=B;
                else nextstate=A;
            end
            B:
            begin
                if(sw[0]) nextstate=C;
                else nextstate=A;
            end
            C:
            begin
                if(sw[0]) nextstate=C;
                else nextstate=D;
            end
            D:
            begin
                if(sw[0]) nextstate=B;
                else 
                begin
                    nextstate=A;
                end
            end
            default: nextstate=4'b0;
            endcase
        end
    end
    //计数
    always@(posedge clk or posedge sw[1])
    begin
        if(sw[1])
            cout<=4'b0;
        else
        begin
            if(button_edge&&currentstate==D&&~sw[0])cout<=cout+4'b1;
            else cout<=cout;
        end
    end
    //状态更新
    always @(posedge clk or posedge sw[1])
    begin
        if(sw[1])
        begin
            outstate<=16'b0;
            outin<=currentstate;
            currentstate<=A;
        end
        else
        begin
            outin<=currentstate;
            if(button_edge)
            begin
                outstate[3:0]<=sw[0];
                outstate[7:4]<=outstate[3:0];
                outstate[11:8]<=outstate[7:4];
                outstate[15:12]<=outstate[11:8];
                currentstate<=nextstate;
            end
        end
    end
    //输出信号选择
    always@(posedge clk_n or posedge sw[1])                     
    begin
        if(sw[1])
            enable<=3'b0;
        else
            if(enable>=3'd5)enable<=3'b0;
            else enable<=enable+3'b1;
    end
    always@(*)
    begin
        case(enable)
        3'd0:begin outdisplay<=cout; selsct<=3'd0; end
        3'd1:begin outdisplay<=outin; selsct<=3'd1; end
        3'd2:begin outdisplay<=outstate[3:0]; selsct<=3'd2; end
        3'd3:begin outdisplay<=outstate[7:4]; selsct<=3'd3; end
        3'd4:begin outdisplay<=outstate[11:8]; selsct<=3'd4; end
        3'd5:begin outdisplay<=outstate[15:12]; selsct<=3'd5; end
        default:begin outdisplay<=cout; selsct<=3'd0; end
        endcase
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

module signal_edge(
    input clk,button,
    output button_edge
);
    reg button_r1,button_r2;
    always@(posedge clk)
    begin
        button_r1<=button;
    end
    always@(posedge clk)
    begin
        button_r2<=button_r1;
    end
    assign button_edge=button_r1&(~button_r2);
endmodule