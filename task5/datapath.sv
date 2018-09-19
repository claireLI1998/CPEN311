module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
						
// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.

wire[3:0] new_card;
wire[3:0] pcard1_out, pcard2_out, dcard1_out, dcard2_out, dcard3_out;

//dealcard module
dealcard dc(.clock(fast_clock), .resetb(resetb), .new_card(new_card));

//reg4 registers
reg4 PCard1(.new_card(new_card), .load_card(load_pcard1), .resetb(resetb), .slow_clock(slow_clock), .card_out(pcard1_out));
reg4 PCard2(.new_card(new_card), .load_card(load_pcard2), .resetb(resetb), .slow_clock(slow_clock), .card_out(pcard2_out));
reg4 PCard3(.new_card(new_card), .load_card(load_pcard3), .resetb(resetb), .slow_clock(slow_clock), .card_out(pcard3_out));

reg4 DCard1(.new_card(new_card), .load_card(load_dcard1), .resetb(resetb), .slow_clock(slow_clock), .card_out(dcard1_out));
reg4 DCard2(.new_card(new_card), .load_card(load_dcard2), .resetb(resetb), .slow_clock(slow_clock), .card_out(dcard2_out));
reg4 DCard3(.new_card(new_card), .load_card(load_dcard3), .resetb(resetb), .slow_clock(slow_clock), .card_out(dcard3_out));

//card7seg
card7seg p1(.card(pcard1_out), .seg7(HEX0));
card7seg p2(.card(pcard2_out), .seg7(HEX1));
card7seg p3(.card(pcard3_out), .seg7(HEX2));

card7seg d1(.card(dcard1_out), .seg7(HEX3));
card7seg d2(.card(dcard2_out), .seg7(HEX4));
card7seg d3(.card(dcard3_out), .seg7(HEX5));

//scorehand
scorehand pscore(.card1(pcard1_out), .card2(pcard2_out), .card3(pcard3_out), .total(pscore_out));
scorehand dscore(.card1(dcard1_out), .card2(dcard2_out), .card3(dcard3_out), .total(dscore_out));
endmodule

module reg4(input[3:0] new_card, input load_card, input resetb, input slow_clock, output reg[3:0] card_out);

always_ff @(negedge slow_clock or negedge resetb) begin
 if(resetb == 1'b0) begin
    card_out <= 1'b0;
 end else begin
    card_out <= new_card;
 end
 end
 
 endmodule
