module task3(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

    // your code here
    logic [7:0] ctaddr, ptaddr;
	logic [7:0] ctdata, ptdata, ptrddata, ctq, ptq;
	logic [23:0] key;
	logic clk, ctwren, ptwren;
	logic protocol, aen, rdy;
    ct_mem ct(.address(ctaddr),
	          .clock(CLOCK_50),
			  .data(ctq),
			  .wren(ctwren),
			  .q(ctq));
    pt_mem pt(.address(ptaddr),
	          .clock(CLOCK_50),
			  .data(ptdata),
			  .wren(ptwren),
			  .q(ptq));
    arc4 a4(.clk(CLOCK_50),
            .rst_n(KEY[3]),
   			.en(aen),
			.rdy(rdy),
			.key({14'b0, SW[9:0]}),
            .ct_addr(ctaddr),
			.ct_rddata(ctq),
			.pt_addr(ptaddr),
			.pt_rddata(ptq),
			.pt_wrdata(ptdata),
			.pt_wren(ptwren));
    // your code here
	//assign key = 24'b111100100011000000000;
	// assign key = 24'b11000;
	always@(posedge CLOCK_50 or negedge KEY[3]) begin
	 if(KEY[3] == 0) begin
	  aen = 0;
	  protocol = 1;
	 end else if(protocol == 1 && rdy == 1) begin
	  aen = 1;
	  protocol = 0;
	 end else begin
	  aen = 0;
	 end
	end
	
	
endmodule: task3
