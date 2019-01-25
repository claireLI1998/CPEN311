`timescale 1ps / 1ps
module tb_task1();

// Your testbench goes here.
logic [9:0] SW;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic en, rdy;
logic [7:0] addr;
logic [7:0] wrdata;
logic wren;
logic [8:0] temp;
logic [7:0] i;

logic CLOCK_50;
logic [3:0] KEY;

task1 dut(.*);

initial begin
CLOCK_50 = 1'b0; #5;
forever begin
CLOCK_50 = 1'b1; #5;
CLOCK_50 = 1'b0; #5;
end 
end 

initial begin
KEY[3] = 1'b1; #5;
KEY[3] = 1'b0; #5;
assert(dut.rdy === 1'b1);
KEY[3] = 1'b1;#10;
assert(dut.en === 1'b1);
assert(dut.addr === 0);
assert(dut.wrdata === 0);
assert(dut.en === 1);
#10;
assert(dut.en === 1'b0);
assert(dut.rdy === 1'b0);
i = 1;
for(temp = 1; temp < 256; temp ++) begin
 assert(dut.addr === i);
 assert(dut.wrdata === i);
 assert(dut.wren === 1);
 i = i + 1;
 #10;
end

$display("Test passed");
$stop;
end


endmodule: tb_task1
