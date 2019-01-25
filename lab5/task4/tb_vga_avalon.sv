`timescale 1ps / 1ps
module tb_vga_avalon();

// Your testbench goes here.

logic clk;
logic reset_n;
logic [3:0] address;
logic read, write;
logic [31:0] writedata, readdata;
logic [7:0] VGA_R, VGA_G, VGA_B;
logic VGA_CLK, VGA_HS, VGA_VS;
logic [7:0] vga_x;
logic [6:0] vga_y;
logic [3:0] vga_colour;
logic [8:0] i;

vga_avalon dut(.*);

	
initial begin
 clk = 1'b1; #5;
 forever begin
  clk = 1'b0; #5;
  clk = 1'b1; #5;
 end 
end 

initial begin
 address = 4'b0;
 reset_n = 1'b1; #5;
 reset_n = 1'b0; #5;
 read = 1'b1;
 reset_n = 1'b1;
 writedata = 32'b0000000000000_100_00000000_0_0000000; 
 #6;
 for(i = 0; i < 120; i ++) begin
  assert(dut.vga_colour === 3'b100);
  assert(dut.vga_x === 8'b0);
  assert(dut.vga_y === writedata[6:0]);
  writedata = writedata + 1'b1;
  #5;
 end 
 #10;
 writedata = 32'b0000000000000_001_00000001_0_0000000;
 #6;
 for(i = 0; i < 120; i ++) begin
  assert(dut.vga_colour === 3'b001);
  assert(dut.vga_x === writedata[15:8]);
  assert(dut.vga_y === writedata[6:0]);
  writedata = writedata + 9'b100000001;
  #5;
 end 
 #10;
 $display("Test Passed");
 $stop();
 end
endmodule: tb_vga_avalon
