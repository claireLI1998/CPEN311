module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output reg player_win_light, output reg dealer_win_light);

// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

reg[3:0] state, next_state;
reg[5:0] loadcards;
assign{load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3}=loadcards;
parameter
state1 = 4'b0001,
state2 = 4'b0010,
state3 = 4'b0011,
state4 = 4'b0100,
state5 = 4'b0101,
state6 = 4'b0110,
state7 = 4'b0111,
finish = 4'b1000;

always @(negedge slow_clock or negedge resetb)begin

if(slow_clock == 1'b0) begin
state <= next_state;
end

else begin
state <= state1;
end

end

always @(*) begin

case(state)
  state1: next_state = state2;
  state2: next_state = state3;
  state3: next_state = state4;
  state4:
     if((pscore == 8 ^ pscore == 9) || (dscore == 8 ^ dscore == 9)) begin
      next_state = finish;
     end else if(pscore >= 0 && pscore <= 5) begin
      next_state = state5;
     end else if(pscore == 6 ^ pscore == 7) begin
      next_state = state7;
     end else begin
      next_state = state4;
     end

  state5: next_state = state6;
  state6: next_state = finish;
  state7: next_state = finish;

  finish: next_state = (resetb == 1'b0)?state1: finish;
  default: next_state = state1;
endcase
end

always@(*) begin
{player_win_light, dealer_win_light} = 2'b00;
case(state)
state1: loadcards = 6'b000001;//pcard1
state2: loadcards = 6'b001000;//dcard1
state3: loadcards = 6'b000010;//pcard2
state4: loadcards = 6'b010000;//dcard2
state5: loadcards = 6'b000100;//pcard3
state6: if(dscore == 7) begin
        loadcards = 6'b000000;
		end else if(dscore == 6) begin
		  loadcards = ((pcard3 == 6)^(pcard3 == 9))?6'b100000:6'b000000;
		end else if(dscore == 5) begin
		  loadcards = ((pcard3 == 4)^(pcard3 == 5)^(pcard3 == 6)^(pcard3 == 7))?6'b100000: 6'b000000;
        end else if(dscore == 4) begin
		  loadcards = ((pcard3 == 2)^(pcard3 == 3)^(pcard3 == 4)^(pcard3 == 5)^(pcard3 == 6)^(pcard3 == 7))?6'b100000:6'b000000;
		end else if(dscore == 3)begin
		  loadcards = (pcard3 != 8)?6'b100000:6'b000000;
		end else begin
		  loadcards = ((dscore >= 0) && (dscore <= 2))?6'b100000:6'b000000;
        end
state7: loadcards = ((dscore >= 0) && (dscore <= 5))?6'b100000:6'b000000;
finish: begin
        loadcards = 6'b000000;
        if(pscore > dscore)begin
          player_win_light = 1'b1;
	end else if(pscore < dscore)begin
	  dealer_win_light = 1'b1;
	end else begin
	  {player_win_light,dealer_win_light} = 2'b11;
	end
        end
       default: loadcards = 6'b000000;

endcase
end

endmodule
