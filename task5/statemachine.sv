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
reg[5:0] lc;
assign {load_dcard3, load_dcard2, load_dcard1, load_pcard3, load_pcard2, load_pcard1} = lc;

parameter
state1 = 4'b0001,
state2 = 4'b0010,
state3 = 4'b0011,
state4 = 4'b0100,
state5 = 4'b0101,
state6 = 4'b0110,
state7 = 4'b0111,
finish = 4'b1000;


always_ff @(negedge slow_clock or negedge resetb) begin
   if(resetb == 1'b0) begin
     state <= state1;
   end else begin
     state <= next_state;
   end
end


always @(*) begin
 player_win_light = 1'b0;
 dealer_win_light = 1'b0;
 case(state)

  state1:
         begin
         lc = 6'b000001;
         next_state = state2;
         end

  state2:
         begin
         lc = 6'b001000;
         next_state = state3;
         end

  state3:
         begin
         lc = 6'b000010;
         next_state = state4;
         end

  state4:
         begin
         lc = 6'b010000;
         if((pscore == 8 ^ pscore == 9) || (dscore == 8 ^ dscore == 9))begin
          next_state = finish;
         end else if(pscore == 0 ^ pscore == 1 ^ pscore == 2 ^ pscore == 3 ^ pscore == 4 ^ pscore == 5)begin
          next_state = state5;
         end else if(pscore == 6 ^ pscore == 7)begin
          next_state = state7;
         end else begin
          next_state = state4;
         end
         end

  state5:
         begin
         lc = 6'b000100;
         next_state = state6;
         end

  state6:
         begin
         if(dscore == 7)begin
          lc = 6'b000000;
         end else if(dscore == 6)begin
          lc = (pcard3 == 6 ^ pcard3 == 7) ? 6'b100000 : 6'b000000;
         end else if(dscore == 5)begin
          lc = (pcard3 >= 4 && pcard3 <= 7) ? 6'b100000 : 6'b000000;
         end else if(dscore == 5)begin
          lc = (pcard3 >= 2 && pcard3 <= 7) ? 6'b100000 : 6'b000000;
         end else if(dscore == 3)begin
          lc = (pcard3 != 8) ? 6'b100000 : 6'b000000;
         end else if(dscore >= 0 && dscore <= 2)begin
          lc = 6'b100000;
         end else begin
          lc = 6'b000000;
         end
         next_state = finish;
         end

  state7:
         begin
         lc = (dscore >= 0 && dscore <= 5) ? 6'b100000 : 6'b000000;
         next_state = finish;
         end

  finish:
         begin
         lc = 6'b000000; //stop distribute cards
         if(pscore > dscore)begin
           player_win_light = 1'b1;
         end else if(pscore < dscore)begin
           dealer_win_light = 1'b1;
         end else if(pscore == dscore)begin
           player_win_light = 1'b1;
           dealer_win_light = 1'b1;
         end
         next_state = (resetb == 1'b0) ? state1 : finish;
         end

  default:
         begin
         next_state = state1;
         lc = 6'b000000;
         end
  endcase
  end

endmodule
