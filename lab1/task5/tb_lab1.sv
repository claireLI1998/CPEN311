module tb_lab1();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").


logic CLOCK_50;
logic[3:0] KEY;

wire[9:0] LEDR;
wire[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

lab1 dut(.*);

initial begin
KEY[0] = 1'b1; #20;
forever begin
KEY[0] = 1'b0; #20;
KEY[0] = 1'b1; #20;
end
end

initial begin
CLOCK_50 = 1'b1; #10;
forever begin
CLOCK_50 = 1'b0; #10;
CLOCK_50 = 1'b1; #10;
end
end

initial begin
KEY[1] = 1'b0;
KEY[2] = 1'b0;

KEY[3] = 1'b0; //reset button
#40;
KEY[3] = 1'b1;
#300;
KEY[3] = 1'b0;
#10;

KEY[3] = 1'b0;
#40;
KEY[3] = 1'b1;
#300;
KEY[3] = 1'b0;
#10;

$assert("Test Passed");

$stop;
end

endmodule
