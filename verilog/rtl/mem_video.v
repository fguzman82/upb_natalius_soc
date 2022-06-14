`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Pontificia Bolivariana
// Engineer:      Fabio Andres Guzman Figueroa
// 
// Create Date:    11:47:57 05/17/2012 
// Design Name: 
// Module Name:    mem_video 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mem_video(
    input clk,
	 input we,
    input [10:0] addr_write,
    input [10:0] addr_read,
    input [2:0] din,
    output reg [2:0] dout
    );

	reg [2:0] ram_video [2048:0];
	
	  
   always @(posedge clk) 
		begin
			if (we)
				ram_video[addr_write] <= din;
			dout <= ram_video[addr_read];
		end
		
endmodule
