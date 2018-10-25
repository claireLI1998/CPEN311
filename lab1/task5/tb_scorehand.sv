module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

reg[3:0] card1, card2, card3;
wire[3:0] total;

scorehand dut(.*);

initial begin

card1 = 4'b0001; //1
card2 = 4'b1011; //J
card3 = 4'b0111; //7
#20;
assert(total == 8) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end

card1 = 4'b1010; //10
card2 = 4'b0010; //2
card3 = 4'b1101; //King
#20;
assert(total == 2)begin
 $display("Test passed");
end else begin
 $display("Test failed");
end


card1 = 4'b0110; //6
card2 = 4'b1000; //8
#20;
assert(total == 4) begin
 $display("Test passed");
end else begin
 $display("Test failed");
end

card1 = 4'b0010; //2
card2 = 4'b0100; //4
#20;
assert(total == 6) begin
 $display("Test paased");
end else begin
 $display("Test failed");
end

$stop;
end

endmodule
