`timescale 1 ns /1 ns

`define B15to0H     3'b000
`define AandBH      3'b011
`define AorBH       3'b100
`define AaddBH      3'b001
`define AsubBH      3'b010
`define leftshift   3'b101
`define rightshift  3'b110

module alu (
	  clk, rst, 
	en_in, alu_a, alu_b, alu_func, en_out, alu_out, z_flag, z_en
);
input [15:0] alu_a, alu_b;
input clk, rst, en_in;
input [2:0] alu_func;
output [15:0] alu_out;
output en_out;
reg z_flag,z_en;
output z_flag,z_en;
reg [15:0] alu_out;
reg  en_out;

	always @(
		posedge clk or negedge rst
	) 
	begin
	   if(rst ==1'b0)
			begin
				alu_out = 16'b0000000000000000;
				en_out  = 1'b0;
			end		
				
		else if(en_in == 1'b1)
			begin
				en_out  = 1'b1;
			case (alu_func)//alu_func来路：instruction->opcode->对应的状�?->对应的控制信�?->alu_func
				`B15to0H:alu_out <= alu_b;
				`AandBH: alu_out <= alu_a & alu_b;
				`AorBH:  alu_out <= alu_a | alu_b;
				`AaddBH:  alu_out <= alu_a + alu_b ;
				`AsubBH:  alu_out <= alu_a - alu_b;
				`leftshift:  alu_out <= alu_a<<1;
				`rightshift:  alu_out <= alu_a>>1;
				default: alu_out <= 16'b0000000000000000;
			endcase
			end
		else
			en_out = 1'b0;	
		if(alu_func == `AsubBH&&alu_out == 0)
	        begin
	        z_en <= 1;
	        z_flag <= 1;
	        end
	        else
	        begin	        
			z_en <= 1;
	        z_flag <= 0;
	        end

	end
endmodule

