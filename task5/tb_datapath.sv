module tb_datapath();

logic fast_clock, slow_clock, resetb;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pscore_out, dscore_out;
logic [3:0] pcard3_out;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

datapath dut(.*);

initial begin
slow_clock = 1'b1;#5;
forever begin
slow_clock = 1'b0;#5;
slow_clock = 1'b1;#5;
end
end

initial begin
resetb = 1'b1;
slow_clock = 1'b0;
load_pcard1 = 0;
load_pcard2 = 0;
load_pcard3 = 0;
load_dcard1 = 0;
load_dcard2 = 0;
load_dcard3 = 0;
#5;
resetb = 0;
#5;
slow_clock = 1'b1;
#5;
resetb = 1;
//p1
#5;
slow_clock = 0;
#5;
load_pcard1 = 1;
slow_clock = 1;
//d1
#5;
slow_clock = 0;
#5;
load_pcard1 = 0;
load_dcard1 = 1;
slow_clock = 1;
//p2
#5;
slow_clock = 0;
#5;
load_pcard2 = 1;
load_dcard1 = 0;
slow_clock = 1;
//d2
#5;
slow_clock = 0;
#5;
load_pcard2 = 0;
load_dcard2 = 1;
slow_clock = 1;
//done
#5;
slow_clock = 0;
#5;
load_pcard2 = 0;
load_dcard2 = 0;
slow_clock = 1;
#20;



//test2
resetb = 1'b1;
slow_clock = 1'b0;
load_pcard1 = 0;
load_pcard2 = 0;
load_pcard3 = 0;
load_dcard1 = 0;
load_dcard2 = 0;
load_dcard3 = 0;
#5;
resetb = 0;
#5;
slow_clock = 1'b1;
#5;
resetb = 1;
//p1 9
#8;
slow_clock = 0;
#8;
load_pcard1 = 1;
slow_clock = 1;
//d1 12
#3;
slow_clock = 0;
#3;
load_pcard1 = 0;
load_dcard1 = 1;
slow_clock = 1;
//p2 2
#3;
slow_clock = 0;
#3;
load_pcard2 = 1;
load_dcard1 = 0;
slow_clock = 1;
//d2 10
#8;
slow_clock = 0;
#8;
load_pcard2 = 0;
load_dcard2 = 1;
slow_clock = 1;
//p3 3
#6;
slow_clock = 0;
#6;
load_pcard3 = 1;
load_dcard2 = 0;
slow_clock = 1;
//d3 6
#3;
slow_clock = 0;
#3;
load_pcard3 = 0;
load_dcard3 = 1;
slow_clock = 1;
//done
#5;
slow_clock = 0;
#5;
load_pcard3 = 0;
load_dcard3 = 0;
slow_clock = 1;
#20;



$stop;
end

endmodule
