`timescale 1ps / 1ps
module tb_task3();

// Your testbench goes here.
logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] SW;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;


task3 dut(.*);

initial begin
 CLOCK_50 = 1'b1; #5;
 forever begin
  CLOCK_50 = 1'b0; #5;
  CLOCK_50 = 1'b1; #5;
 end 
end 

initial begin
#11;
 $readmemh("test2.memh", dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data);
end

initial begin
 SW = 10'h18;
 KEY[3] = 1'b1; #5;
 KEY[3] = 1'b0; #5;
 KEY[3] = 1'b1;
 #400000;
 $stop;
 end
 

endmodule: tb_task3
