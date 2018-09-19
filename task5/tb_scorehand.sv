module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

reg[3:0] card1, card2, card3;
wire[3:0] total;

scorehand sh(.*);

initial begin

card1 = $urandom_range(13);
card2 = $urandom_range(13);
card3 = $urandom_range(13);
#20;
$display(card1, card2, card3, total);

card1 = $urandom_range(13);
card2 = $urandom_range(13);
card3 = $urandom_range(13);
#20;
$display(card1, card2, card3, total);

card1 = $urandom_range(13);
card2 = $urandom_range(13);
card3 = $urandom_range(13);
#20;
$display(card1, card2, card3, total);

$stop;
end
					
endmodule

