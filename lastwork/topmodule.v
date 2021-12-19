`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name:
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module topmodule (
    input clk,rst,button,
    input [7:1] sw,
    output [7:0] led,
    output reg [3:0] out,
    output reg [2:0] selsct
);

    wire clk_n;
    wire button_n;
    wire button_edge;
    wire rst_n,rst_edge;
    jtrclr clr(.clk(clk),.button(button),.button_n(button_n));
    signal_edge cedge(.clk(clk),.button(button_n),.button_edge(button_edge));
    jtrclr clr1(.clk(clk),.button(rst),.button_n(rst_n));
    signal_edge cedge1(.clk(clk),.button(rst_n),.button_edge(rst_edge));
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(rst),.locked(locked));

    parameter IDLE  = 4'd0;
    parameter LOCKED= 4'd1;
    parameter ERROR = 4'd2;
    parameter ERRORLOCKED= 4'd3;
    parameter WORK = 4'd4;
    parameter CLOCK = 4'd5;

    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    parameter E = 2'd3;

    reg usercheck;
    reg [1:0] error_cout;
    reg [3:0] curr_state;
    reg [3:0] next_state;

    wire is_check_cmd;
    assign is_check_cmd=rst_edge;
    reg [1:0] inputcout;
    reg [1:0] pa_custate;
    reg [1:0] pa_nestate;
    reg [6:0] password1;
    reg [6:0] password2;
    reg [6:0] password3;

    reg [19:0] cout;
    reg [3:0] clock1,clock2,clock3;
    reg clockfinished;
    reg clockstart;
    wire pulse_10hz;

    reg [3:0] hexdisplay [7:0];

    always@(posedge clk or posedge rst)
    begin
        if(rst)
            curr_state  <= IDLE;
        else
            curr_state  <= next_state;
    end
    always@(*)
    begin
        case(curr_state)
        IDLE: begin if(button_edge) next_state=LOCKED; else next_state=IDLE; end
        LOCKED: begin
            if(button_edge) begin 
                if(usercheck) 
                    next_state=WORK; 
                else begin 
                    if(error_cout==2'd2) 
                        next_state=ERRORLOCKED;
                    else 
                        next_state=ERROR;
                end
            end
            else next_state=LOCKED;
        end
        ERROR:begin
            next_state = LOCKED;
            // if(finished) next_state=LOCKED;
            // else next_state=ERROR;
        end
        ERRORLOCKED: begin
            if(clockfinished) 
                next_state=LOCKED;
            else 
                next_state=ERRORLOCKED;
        end
        WORK: begin
            if(rst) 
                next_state=IDLE;
            if(sw[1]) 
                next_state=CLOCK; 
            else 
                next_state=WORK;
        end
        default: next_state=IDLE; 
        endcase
    end


    always@(posedge clk or posedge rst)begin
        if(rst)begin
            usercheck<=1'b0;
            pa_custate<=A;
        end
        else begin
            if(pa_custate==C&&next_state==A) usercheck<=1;
            else if(button_edge) usercheck<=0;
            pa_custate<=pa_nestate;
        end
    end
    always@(posedge clk or posedge rst)begin
        if(rst)
            inputcout <= 2'b0;
        else begin
            if(is_check_cmd)
            begin 
                inputcout<=inputcout+2'b1;
            end
        end
    end
    always@(posedge clk or posedge rst)begin
        if(rst)error_cout<=2'b0;
        else if(button_edge&&(~usercheck))
        begin
            if(error_cout==2'd2)error_cout<=2'b0;
            else error_cout<=error_cout+2'b1;
        end
    end
    always@(*)begin
        if(button_edge) pa_nestate=A;
        if(is_check_cmd)begin
            case(pa_custate)
            A: begin 
                if(sw[7:1]==password1)
                    pa_nestate=B;
                else pa_nestate=E;
            end
            B: begin
                if(sw[7:1]==password2)
                    pa_nestate=C;
                else pa_nestate=E;
            end
            C: begin
                if(sw[7:1]==password3)
                    pa_nestate=A;
                else pa_nestate=E;
            end
            E: begin
                if(inputcout==2'd3)
                    pa_nestate=A;
                else pa_nestate=E;
            end
            endcase
        end
    end


    always@(posedge clk_n or posedge rst)                     
    begin
        if(rst)
        begin
            cout<=20'b0;
        end
        else
        begin
            if(cout>=20'd999999)
            cout<=20'b0;
            else cout<=cout+20'b1;
        end
    end
    assign pulse_10hz=(cout==20'd999999);
    always@(posedge clk or posedge rst)
    begin
        if(rst || clockfinished) begin
            clock1 <= 4'd0;
            clock2 <= 4'd0;
            clock3 <= 4'd0;
            clockfinished <=1'b0;
            clockstart <= 1'b0;
        end
        else if(error_cout==2'd2)begin
            clock1 = 4'd6;
            clockstart <=1'b1;
        end
        else
            begin
                if(clockstart)
                begin
                    if(pulse_10hz)
                    begin
                        if(clock3==4'b0)begin
                            clock3<=4'd9;
                            if(clock2==4'b0)begin
                                clock2<= 4'd9;
                                if(clock1==4'b0) clockfinished<=1'b1;
                                else clock1<=clock1-4'b1;
                            end
                            else clock2<=clock2-4'b1;
                        end
                        else clock3<=clock3-4'b1;
                    end
                end
            end
    end

    reg [2:0] enable;
    always@(posedge clk_n)
    begin
        enable=enable+1'b1;
    end
    always@(*)
    begin
        case(enable)
        3'd1: begin out=hexdisplay[0];selsct=3'd0; end
        3'd1: begin out=hexdisplay[1];selsct=3'd1; end
        3'd1: begin out=hexdisplay[2];selsct=3'd2; end
        3'd1: begin out=hexdisplay[3];selsct=3'd3; end
        3'd1: begin out=hexdisplay[4];selsct=3'd4; end
        3'd1: begin out=hexdisplay[5];selsct=3'd5; end
        3'd1: begin out=hexdisplay[6];selsct=3'd6; end
        3'd1: begin out=hexdisplay[7];selsct=3'd7; end
        default:begin out=hexdisplay[0];selsct=3'b0; end
        endcase
    end

    always@(posedge clk)
    begin
        if(curr_state==ERRORLOCKED)
        begin
            hexdisplay[0]<=clock3;
            hexdisplay[1]<=clock2;
            hexdisplay[2]<=clock1;
        end
        else begin
            hexdisplay[0]<=0;
            hexdisplay[1]<=0;
            hexdisplay[2]<=0;  
            hexdisplay[3]<=0;
            hexdisplay[4]<=0;  
            hexdisplay[5]<=0;
            hexdisplay[6]<=0;
            hexdisplay[7]<=0;
        end
    end

    assign led={2'b0,pa_custate,curr_state};

    initial begin
        usercheck=0;error_cout=0;
        password1=0;password2=0;password3=0;
        clockfinished=0; clockstart=0;
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