module task2(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);



  logic [7:0] initaddr, ksaaddr, addr;
	logic [7:0] initwrdata, ksawrdata, wrdata, q;
	logic initen, initrdy, initwren, initdone, ksaen, ksardy, ksawren, wren;
	logic [23:0] key;
	logic [1:0] protocol;
 	s_mem s(.address(addr), 
	        .clock(CLOCK_50), 
			.data(wrdata), 
			.wren(wren), 
			.q(q));
			
	init i(.clk(CLOCK_50), 
	       .rst_n(KEY[3]), 
		   .en(initen), 
		   .rdy(initrdy), 
		   .addr(initaddr), 
		   .wrdata(initwrdata), 
		   .wren(initwren), 
		   .done(initdone));
		   
    ksa k(.clk(CLOCK_50), 
	      .rst_n(KEY[3]), 
		  .en(ksaen), 
		  .rdy(ksardy), 
		  .key({14'b0, SW[9:0]}), 
		  .addr(ksaaddr), 
		  .rddata(q), 
		  .wrdata(ksawrdata), 
		  .wren(ksawren));
	
    // your code here
	always @(posedge CLOCK_50) begin
	 if(!KEY[3]) begin
	  initen = 1'b0;
	  ksaen = 1'b0;
	  protocol = 2'b00;
	 end else if(initrdy == 1'b1 && protocol == 2'b00) begin
	  initen = 1'b1;
	  protocol = 2'b01;
	 end else if(initdone == 1'b1 && ksardy == 1'b1 && protocol == 2'b01) begin
	  initen = 0;
	  ksaen = 1'b1;
	  protocol = 2'b10;
	 end else begin
	  initen = 1'b0;
	  ksaen = 1'b0;
	 end 
	end 
	 
	always @(posedge CLOCK_50) begin
	 if(initdone == 1'b0) begin
	  wrdata = initwrdata;
	  addr = initaddr;
	  wren = initwren;
	 end else begin
	  wrdata = ksawrdata;
	  addr = ksaaddr;
	  wren = ksawren;
	 end 
	end

endmodule: task2
