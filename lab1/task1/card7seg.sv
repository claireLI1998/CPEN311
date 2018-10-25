module card7seg(input [3:0] SW, output reg[6:0] HEX0);
always @(*) begin
case (SW)
				4'b0000: HEX0 = 7'b1111111; //display nothing
				4'b0001: HEX0 = 7'b0001000; //display A
				4'b0010: HEX0 = 7'b0100100; //display 2
				4'b0011: HEX0 = 7'b0110000; //display 3
				4'b0100: HEX0 = 7'b0011001; //display 4
				4'b0101: HEX0 = 7'b0010010; //display 5
				4'b0110: HEX0 = 7'b0000010; //display 6
				4'b0111: HEX0 = 7'b1111000; //display 7
				4'b1000: HEX0 = 7'b0000000; //display 8
				4'b1001: HEX0 = 7'b0010000; //display 9
				4'b1010: HEX0 = 7'b1000000; //display 0

				4'b1011: HEX0 = 7'b1100001; //display J
				4'b1100: HEX0 = 7'b0011000; //display q
				4'b1101: HEX0 = 7'b0001001; //display H as King

				default: HEX0 = 7'b1111111; // default: display nothing
			endcase
end
   // your code goes here

endmodule
