`timescale 1ns / 1ps
//
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 12:20:32
// Design Name: 
// Module Name: uart_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//


module uart_top
(
input                           sys_clk_p,         //system clock positive
input                           sys_clk_n,         //system clock negative 
input                           rst_n,             //reset ,low active
input                           uart_rx,           //fpga receive data
output                          uart_tx            //fpga send data
);
parameter                       clk_fre = 200;    //Mhz
localparam                       IDLE =  0;
localparam                       SEND =  1;         //send HELLO ALINX\r\n
localparam                       WAIT =  2;         //wait 1 second and send uart received data
reg[7:0]                         tx_data;          //sending data
reg[7:0]                         tx_str;
reg                              tx_data_valid;    //sending data valid
wire                             tx_data_ready;    //singal for sending data
reg[7:0]                         tx_cnt=0; 
wire[7:0]                        rx_data;          //receiving data
wire                             rx_data_valid;    // receiving data valid
wire                             rx_data_ready;    // singal for receiving data
reg[31:0]                        wait_cnt=0;
reg[3:0]                         state=0;          
wire                             sys_clk;          //single end clock
/*************************************************************************
generate single end clock
**************************************************************************/
IBUFDS sys_clk_ibufgds   
(
.O                      (sys_clk                  ),
.I                      (sys_clk_p                ),
.IB                     (sys_clk_n                )
);
assign rx_data_ready = 1'b1;//always can receive data,
							//if HELLO ALINX\r\n is being sent, the received data is discarded
/*************************************************************************
1 second sends a packet HELLO ALINX\r\n , FPGA has been receiving state
****************************************************************************/
always@(posedge sys_clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		wait_cnt <= 32'd0;
		tx_data <= 8'd0;
		state <= IDLE;
		tx_cnt <= 8'd0;
		tx_data_valid <= 1'b0;
	end
	else
	case(state)
		IDLE:
			state <= SEND;
		SEND:
		begin
			wait_cnt <= 32'd0;
			tx_data <= tx_str;

			if(tx_data_valid == 1'b1 && tx_data_ready == 1'b1 && tx_cnt < 8'd12)//Send 12 bytes data
			begin
				tx_cnt <= tx_cnt + 8'd1; //Send data counter
			end
			else if(tx_data_valid && tx_data_ready)//last byte sent is complete
			begin
				tx_cnt <= 8'd0;
				tx_data_valid <= 1'b0;
				state <= WAIT;
			end
			else if(~tx_data_valid)
			begin
				tx_data_valid <= 1'b1;
			end
		end
		WAIT:
		begin
			wait_cnt <= wait_cnt + 32'd1;
            // 等待1s 数据的时候
			if(rx_data_valid == 1'b1) // 如果接收到数据
			begin
				tx_data_valid <= 1'b1; //使得发送数据使能，
				tx_data <= rx_data;   // send uart received data
			end
			else if(tx_data_valid && tx_data_ready)
			begin
				tx_data_valid <= 1'b0;
			end
			else if(wait_cnt >= clk_fre * 1000000) // wait for 1 second
				state <= SEND;
		end
		default:
			state <= IDLE;
	endcase
end
/*************************************************************************
combinational logic  Send "HELLO ALINX\r\n"
****************************************************************************/
always@(*)
begin
	case(tx_cnt)
		8'd0 :  tx_str <= "H";
		8'd1 :  tx_str <= "E";
		8'd2 :  tx_str <= "L";
		8'd3 :  tx_str <= "L";
		8'd4 :  tx_str <= "O";
		8'd5 :  tx_str <= " ";
		8'd6 :  tx_str <= "A";
		8'd7 :  tx_str <= "L";
		8'd8 :  tx_str <= "I";
		8'd9 :  tx_str <= "N";
		8'd10:  tx_str <= "X";
		8'd11:  tx_str <= "\r";
		8'd12:  tx_str <= "\n";
		default:tx_str <= 8'd0;
	endcase
end
/***************************************************************************
calling uart_tx module and uart_rx module
****************************************************************************/
uart_rx#
(
.clk_fre(clk_fre),
.baud_rate(115200)
) uart_rx_inst
(
.clk                        (sys_clk                  ),
.rst_n                      (rst_n                    ),
.rx_data                    (rx_data                  ),
.rx_data_valid              (rx_data_valid            ),
.rx_data_ready              (rx_data_ready            ),
.rx_pin                     (uart_rx                  )
);

uart_tx#
(
.clk_fre(clk_fre),
.baud_rate(115200)
) uart_tx_inst
(
.clk                        (sys_clk                  ),
.rst_n                      (rst_n                    ),
.tx_data                    (tx_data                  ),
.tx_data_valid              (tx_data_valid            ),
.tx_data_ready              (tx_data_ready            ),
.tx_pin                     (uart_tx                  )
);

endmodule