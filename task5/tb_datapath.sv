module tb_datapath();

logic fast_clock, slow_clock, resetb;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pscore_out, dscore_out;
logic [3:0] pcard3_out;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

datapath dut(.*);


initial begin
slow_clock = 1'b0;#10;
forever begin
slow_clock = 1'b1;#10;
slow_clock = 1'b0;#10;
end
end

initial begin
fast_clock = 1'b0;#3;
forever begin
fast_clock = 1'b1;#3;
fast_clock = 1'b0;#3;
end
end

initial begin
//test1
slow_clock = 1'b0;
resetb = 1'b0;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#10;
slow_clock = 1'b1;#5;
resetb = 1'b1;
load_pcard1 = 1'b1;
#5;
slow_clock = 1'b0;
#2;
slow_clock = 1'b1;
#3;
load_pcard1 = 1'b0;
load_dcard1 = 1'b1;
#1;
slow_clock = 1'b0;
#4;
slow_clock = 1'b1;
#5
load_dcard1 = 1'b0;
load_pcard2 = 1'b1;
#2;
slow_clock = 1'b0;
#6;
slow_clock = 1'b1;
#5;
load_pcard2 = 1'b0;
load_dcard2 = 1'b1;
#3;
slow_clock = 1'b0;
#12;


//test2
slow_clock = 1'b0;
resetb = 1'b1;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#7;

slow_clock = 1'b1;
#5;
resetb = 1'b0;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#5;
resetb = 1'b1;
load_pcard1 = 1'b1;
#5;
slow_clock = 1'b0;
#5;
slow_clock = 1'b1;
#2;
slow_clock = 1'b1;
#3;
load_pcard1 = 1'b0;
load_dcard1 = 1'b1;
#4;
slow_clock = 1'b0;
#4;
slow_clock = 1'b1;
#2;
load_dcard1 = 1'b0;
load_pcard2 = 1'b1;
#4;
slow_clock = 1'b0;
#3;
slow_clock = 1'b1;
#3;
load_pcard2 = 1'b0;
load_dcard2 = 1'b1;
#3;
slow_clock = 1'b0;
#12;

$stop;
end
endmodule
