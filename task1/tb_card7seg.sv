module tb_card7seg();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").


reg clk;
logic [3:0] SW;
logic [6:0] HEX0;

card7seg dut(.*);
initial begin
clk = 1'b1;#140;
clk = 1'b0;
end

initial begin

SW = 4'b0000;#10;
assert(HEX0===7'b1111111);

SW = 4'b0001;#10;
assert(HEX0===7'b0001000);

SW = 4'b0010;#10;
assert(HEX0===7'b0100100);

SW = 4'b0011;#10;
assert(HEX0===7'b0110000);

SW = 4'b0100;#10;
assert(HEX0===7'b0011001);

SW = 4'b0101;#10;
assert(HEX0===7'b0010010);

SW = 4'b0110;#10;
assert(HEX0===7'b1000000);

SW = 4'b0111;#10;
assert(HEX0===7'b1111000);

SW = 4'b1000;#10;
assert(HEX0===7'b0000000);

SW = 4'b1001;#10;
assert(HEX0===7'b0010000);

SW = 4'b1010;#10;
assert(HEX0===7'b1000000);

SW = 4'b1011;#10;
assert(HEX0===7'b1100001);

SW = 4'b1100;#10;
assert(HEX0===7'b0011000);

SW = 4'b1101;#10;
assert(HEX0===7'b0001001);
$display("Test passed");
end
endmodule
