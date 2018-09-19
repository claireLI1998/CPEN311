module tb_datapath();

reg slow_clock, fast_clock, resetb;
reg load_pcard1, load_pcard2, load_pcard3;
reg load_dcard1, load_dcard2, load_dcard3;
wire[3:0] pscore_out, dscore_out;
wire[6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
wire[3:0] pcard3_out;
wire[41:0] display;
 
datapath dp(.*);

initial begin 
   fast_clock = 1'b0; 
   forever #10 fast_clock = ~fast_clock;
end

initial begin 
   slow_clock = 1'b0;
   forever #50 slow_clock = ~slow_clock;
end

assign HEXset = {HEX0, HEX1, HEX2, HEX3, HEX4, HEX5};

initial begin
resetb = 1'b0;
load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

resetb = 1'b1;

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b100000;
#100;
assert(HEX0 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b010000;
#100;
assert(HEX1 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b001000;
#100;
assert(HEX2 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b000100;
#100;
assert(HEX3 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b000010;
#100;
assert(HEX4 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3} = 6'b000001;
#100;
assert(HEX5 != 7'b1111111)begin
   $display("HEX Test passed");
end else begin
   $display("HEX Test failed");
end 

resetb = 1'b0;
#100;
$stop;
end

endmodule