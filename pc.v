`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/05 17:12:07
// Design Name: 
// Module Name: pc
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
//////////////////////////////////////////////////////////////////////////////////


module pc(
         clk,
         rst		,       
		 en_in		,
		 pc_ctrl  	,
		 offset_addr, 		 			 
		 pc_out  		
    );
    input clk,rst,en_in;
    input wire[1:0] pc_ctrl;
    input wire[7:0] offset_addr;
    output reg[15:0] pc_out;
    always@(posedge clk or negedge rst)
        if(rst==0)
            begin
                pc_out<=0000000000000000;//初始化pc_out
            end
         else
            begin
                 if(en_in==1)//使能信号触发，PC工作
                    begin
                         case (pc_ctrl)
                         2'b01:
                            pc_out <= pc_out + 1;//pc_ctrl=01,pc_out自加1
                         2'b10:
                            pc_out <= {8'b00000000,offset_addr[7:0]};//pc_ctrl=10,pc_out等于offset_addr,同时补位以符合位数要求 
                         default:                                    //offset_addr来自ir_out[7:0], 是jump指令的立即数                 
                                  pc_out <= pc_out;//其余情况pc_out保持不变
                       endcase
                       end
            end   
    
endmodule