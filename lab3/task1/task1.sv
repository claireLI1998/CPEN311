
module task1(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

    // your code here
    logic en, rdy;
	logic [7:0] addr;
	logic [7:0] wrdata;
	logic wren;
	logic p;
	logic [7:0] q;
	
    s_mem s(.address(addr), .clock(CLOCK_50), .data(wrdata), .wren(wren), .q(q));
	init i(.clk(CLOCK_50), .rst_n(KEY[3]), .en(en), .rdy(rdy), .addr(addr), .wrdata(wrdata), .wren(wren)); 
     
	always @(posedge CLOCK_50) begin
	 if(KEY[3] == 1'b0) begin
	  en = 0;
	  p = 1;
	 end else if(p == 1 && rdy == 1) begin
	  en = 1;
	  p = 0;
	 end else begin
	  en = 0;
	 end
	 
	end
	 
    // your code here
	
    
endmodule: task1