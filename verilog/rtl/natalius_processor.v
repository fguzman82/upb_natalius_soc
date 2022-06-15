`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Pontificia Bolivariana
// Engineer:      Fabio Andres Guzman Figueroa
// 
// Create Date:    20:52:12 05/14/2012 
// Design Name: 
// Module Name:    natalius_processor 
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
module natalius_processor(
    input clk,
    input rst,
    output [7:0] port_addr,
    output read_e,
    output write_e,
    input [7:0] data_in,
    output [7:0] data_out,    
    //dualport mem
    input csb0,
    input web0,
    input [1:0]   wmask0, // write mask
    input [10:0]  addr0,
    input [15:0]  din0,
    output [15:0] dout0,
    input   csb1 // active low chip select for read
    );

wire z,c;
wire insel;
wire we;
wire [2:0] raa;
wire [2:0] rab;
wire [2:0] wa;
wire [2:0] opalu;
wire [2:0] sh;
wire selpc;
wire ldpc;
wire ldflag;
wire [10:0] ninst_addr;
wire selk;
wire [7:0] KTE;
wire [10:0] stack_addr;
wire wr_en, rd_en;
wire [7:0] imm;
wire selimm;
wire [15:0] instruction;
wire [10:0] inst_addr;

control_unit control_unit_i(clk,rst,instruction,z,c,port_addr,write_e,read_e,insel,we,raa,rab,wa,opalu,sh,selpc,ldpc,ldflag,ninst_addr,selk,KTE,stack_addr,wr_en,rd_en,imm,selimm);
data_path data_path_i(clk,rst,data_in,insel,we,raa,rab,wa,opalu,sh,selpc,selk,ldpc,ldflag,wr_en,rd_en,ninst_addr,KTE,imm,selimm, data_out,inst_addr,stack_addr,z,c);
dualport_sram inst_mem(
    //w-r
    .clk0(clk),
    .csb0(csb0),
    .web0(web0),
    .wmask0(wmask0),
    .addr0(addr0[10:0]),
    .din0(din0),
    .dout0(dout0),
    .clk1(clk),
    //r
    .csb1(csb1),
    .addr1(inst_addr[10:0]),
    .dout1(instruction)
  );


endmodule
