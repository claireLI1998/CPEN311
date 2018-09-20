module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic slow_clock, resetb;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2,  load_dcard3;
logic player_win_light, dealer_win_light;
logic[3:0] dscore, pscore, pcard3;

statemachine dut(.*);

initial begin
slow_clock = 1'b0;#5;
forever begin
slow_clock = 1'b1;#5;
slow_clock = 1'b0;#5;
end
end

initial begin

//dealer wins
pscore = 1'b0;
dscore = 1'b0;
pcard3 = 1'b0;
resetb = 1'b1;
pscore = 5;#10;
dscore = 4;#10;
pscore = 8;#10;
dscore = 9;#20;
assert(dealer_win_light == 1'b1 && player_win_light == 1'b0) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end

//player wins
pscore = 1'b0;
dscore = 1'b0;
pcard3 = 1'b0;
resetb = 1'b0;#10;
resetb = 1'b1;
pscore = 14;#10;
dscore = 2;#10;
pscore = 8;#10;
dscore = 3;#10;
assert(player_win_light == 1'b1 && dealer_win_light == 1'b0) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end

//dealer wins
pscore = 1'b0;
dscore = 1'b0;
pcard3 = 1'b0;
resetb = 1'b0;#10;
resetb = 1'b1;
pscore = 7;#10;
dscore = 2;#10;
pscore = 7;#10;
dscore = 2;#10;
pscore = 7;#10;
dscore = 8;#10;
assert(dealer_win_light == 1'b1 && player_win_light = 1'b0) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end

//tie
pscore = 1'b0;
dscore = 1'b0;
pcard3 = 1'b0;
resetb = 1'b0;#10;
resetb = 1'b1;
pscore = 3;#10;
dscore = 9;#10;
pscore = 5;#10;
dscore = 5;#10;
assert(player_win_light == 1'b1 && dealer_win_light == 1'b1) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end
$stop;


end


endmodule
