`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Pontificia Bolivariana
// Engineer:      Fabio Andres Guzman Figueroa
// 
// Create Date:    11:31:15 05/17/2012 
// Design Name:    
// Module Name:    pong_top_level
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
module natalius_soc(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
    input clk,
    input rst,
	input [7:0] din,
	output reg [7:0] dout,
	output [20:0] io_oeb,
	output hs,vs,
	output r,g,b,
	//dualport mem
    input wbs_cyc_i,
	input wbs_stb_i,
    input web,
    input [1:0]   wmask0, // write mask
    input [11:0]  addr0,
    input [15:0]  din0,
    output [15:0] dout0
    );


wire csb; 
wire csb1_en;

wire [7:0] data_in;
wire [7:0] port_addr;
wire [7:0] data_out;
wire write_e;

reg [7:0] din_reg;
reg rst_ext;
reg [6:0] col;
reg [5:0] row;
reg [2:0] color;
reg we;

wire [12:0] addr_write, addr_read;
wire [3:0] doutb;
wire [2:0] color_out;
wire [7:0] mem_out;

assign io_oeb = 21'b000001111111100000000;
assign csb = !(wbs_cyc_i && wbs_stb_i);
assign csb1_en = !(wbs_adr_i[11:0] == 12'b100000000000);

always@(posedge clk)
	if (rst_ext==1 || rst==1)
		din_reg<=0;
	else
		din_reg<=din;
		
//col register  (addr=32)
always@(posedge clk or posedge rst)
	if (rst)
		col<=0;
	else
		if (port_addr[7:5]==3'b001 && write_e==1)
			col<=data_out[6:0];
			
			
//row register (addr=64)
always@(posedge clk or posedge rst)
	if (rst)
		row<=0;
	else
		if (port_addr[7:5]==3'b010 && write_e==1)
			row<=data_out[5:0];
			

//color register (addr=96)
always@(posedge clk or posedge rst)
	if (rst)
		color<=0;
	else
		if (port_addr[7:5]==3'b011 && write_e==1)
			color<=data_out[2:0];
			
//we register (addr=160)
always@(posedge clk or posedge rst)
	if (rst)
		we<=0;
	else
		if (port_addr[7:5]==3'b101 && write_e==1)
			we<=data_out[0];			
			
//rst_ext register (addr=128)
always@(posedge clk or posedge rst)
	if (rst)
		rst_ext<=0;
	else
		if (port_addr[7:5]==3'b100 && write_e==1)
			rst_ext<=data_out[0];

//dout register (addr=128)
always@(posedge clk or posedge rst)
	if (rst)
		dout<=0;
	else
		if (port_addr[7:5]==3'b111 && write_e==1)
			dout<=data_out;



assign data_in=(port_addr[7:5]==000) ? mem_out : din_reg; 						

assign addr_write={row, col};

natalius_processor processor(clk,rst,port_addr,read_e,write_e,data_in,data_out, csb, !web, wmask0, addr0[10:0], din0, dout0, csb1_en);
memram ram_memory(clk,data_out,port_addr[4:0],mem_out,write_e);
mem_video video_mem(clk,we,addr_write,addr_read,{1'b0,color},doutb);
vga_control video_cntrl(clk,rst,doutb[2:0],hs,vs,color_out,addr_read);

assign r=color_out[2];
assign g=color_out[1];
assign b=color_out[0];

endmodule
