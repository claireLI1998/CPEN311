module tb_card7seg();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").


reg clk;
logic [3:0] SW;
logic [6:0] HEX0;

card7seg(.*);
initial begin
clk=0;
forever #5 clk = ~clk;
end

initial begin
#10;
SW = 4'b0000;
assert(HEX0===7'b1111111);


#10;
SW = 4'b0001;
assert(HEX0===7'b0001000);

#10;
SW = 4'b0010;
assert(HEX0===7'b0100100);

#10;
SW = 4'b0011;
assert(HEX0===7'b0110000);

#10;
SW = 4'b0100;
assert(HEX0===7'b0011001);

#10;
SW = 4'b0101;
assert(HEX0===7'b0010010);

#10;
SW = 4'b0110;
assert(HEX0===7'b1000000);

#10;
SW = 4'b0111;
assert(HEX0===7'b1111000);

#10;
SW = 4'b1000;
assert(HEX0===7'b0000000);

#10;
SW = 4'b1001;
assert(HEX0===7'b0010000);

#10;
SW = 4'b1010;
assert(HEX0===7'b1000000);

#10;
SW = 4'b1011;
assert(HEX0===7'b1100001);

#10;
SW = 4'b1100;
assert(HEX0===7'b0011000);

#10;
SW = 4'b1101;
assert(HEX0===7'b0001001);

end
endmodule
