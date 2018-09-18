module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output reg[3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout.  Be sure to review the section
// on representing numbers in the lecture notes.

reg [3:0] c1, c2, c3;

always@(*) begin
  if(card1 >= 10) begin
    c1=0;
  end else begin
    c1=card1;
  end

  if(card2 >= 10) begin
    c2=0;
  end else begin
    c2=card2;
  end

  if(card3 >= 10) begin
    c3=0;
  end else begin
    c3=card3;
  end

  total <= (c1 + c2 + c3) % 10;

  end

endmodule
