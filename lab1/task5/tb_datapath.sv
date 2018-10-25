module tb_datapath();

logic fast_clock, slow_clock, resetb;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pscore_out, dscore_out;
logic [3:0] pcard3_out;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

datapath dut(.*);


initial begin
slow_clock = 1'b0;#5;
forever begin
slow_clock = 1'b1;#5;
slow_clock = 1'b0;#5;
end
end

initial begin

resetb = 1'b0;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#10;
resetb = 1'b1;
load_pcard1 = 1'b1;
#10;
load_pcard1 = 1'b0;
load_dcard1 = 1'b1;
#10;
load_dcard1 = 1'b0;
load_pcard2 = 1'b1;
#10;
load_pcard2 = 1'b0;
load_dcard2 = 1'b1;
#10;
load_dcard2 = 1'b0;
#20;


resetb = 1'b0;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#10;
resetb = 1'b1;
load_pcard1 = 1'b1;
#10;
load_pcard1 = 1'b0;
load_dcard1 = 1'b1;
#10;
load_dcard1 = 1'b0;
load_pcard2 = 1'b1;
#10;
load_pcard2 = 1'b0;
load_dcard2 = 1'b1;
#10;
load_dcard2 = 1'b0;
#40;

resetb = 1'b0;
{load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = 6'b000000;
#10;
resetb = 1'b1;
load_pcard1 = 1'b1;
#10;
load_pcard1 = 1'b0;
load_dcard1 = 1'b1;
#10;
load_dcard1 = 1'b0;
load_pcard2 = 1'b1;
#10;
load_pcard2 = 1'b0;
load_dcard2 = 1'b1;
#10;
load_dcard2 = 1'b0;
#40;

$stop;
end
endmodule
