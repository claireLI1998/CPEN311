module arc4(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            input logic [23:0] key,
            output logic [7:0] ct_addr, input logic [7:0] ct_rddata,
            output logic [7:0] pt_addr, input logic [7:0] pt_rddata, output logic [7:0] pt_wrdata, output logic pt_wren);

    // your code here

	logic [7:0] initaddr, ksaaddr, paddr, addr;
	logic [7:0] q;
	logic initdone, ksadone, initwren, ksawren, pwren, wren;
    logic initen, ksaen, pen, t, lock;
	logic initrdy, ksardy, prdy;
	logic [7:0] wrdata, initwrdata, ksawrdata, ksarddata, pwrdata, prddata;
	logic [2:0] count;
	logic [2:0] n;
    s_mem s( .address(addr),
	         .clock(clk),
			 .data(wrdata),
			 .wren(wren),
			 .q(q));
    init i( .clk(clk),
	        .rst_n(rst_n),
			.en(initen),
			.rdy(initrdy),
			.addr(initaddr),
			.wrdata(initwrdata),
			.wren(initwren),
			.done(initdone));
			
    ksa k( .clk(clk),
           .rst_n(rst_n),
           .en(ksaen),
		   .rdy(ksardy),
		   .key(key),
		   .addr(ksaaddr),
		   .rddata(ksarddata),
		   .wrdata(ksawrdata),
		   .wren(ksawren),
		   .done(ksadone));
		   
    prga p(.clk(clk),
           .rst_n(rst_n),
		   .en(pen),
		   .rdy(prdy),
		   .key(key),
		   .s_addr(paddr),
		   .s_rddata(prddata),
		   .s_wrdata(pwrdata),
		   .s_wren(pwren),
		   .ct_addr(ct_addr),
		   .ct_rddata(ct_rddata),
		   .pt_addr(pt_addr),
		   .pt_rddata(pt_rddata),
		   .pt_wrdata(pt_wrdata),
		   .pt_wren(pt_wren));

    // your code here
	assign initen = en;
	

	always_ff @(posedge clk or negedge rst_n) begin
	 if(!rst_n) begin
	  ksaen = 0;
	  pen = 0;
	  rdy = 1;
	  n = 0;
	 end 
	 
	 else begin
	   if(en == 1) begin
	    rdy = 0;
	   end else begin
        if(initdone == 1 && ksadone == 0 && n == 0)begin
	     ksaen = 1;
	     pen = 0;
		 n = 1;
	    end else if(initdone == 1 && ksadone == 1 && n == 1)begin
	     pen = 1;
		 ksaen = 0;
		 n = 2;
	    end else begin
		 ksaen = 0;
		 pen = 0;
	    end
	   end 
	 end
	end
	
	
	
	
	always@(*) begin
	 if({initdone, ksadone} == 2'b00) begin
	  wrdata = initwrdata;
	  addr = initaddr;
	  wren = initwren;
	  ksarddata = q;
	 end else if({initdone, ksadone} == 2'b10) begin	  	  
	  wrdata = ksawrdata;
	  addr = ksaaddr;
	  wren = ksawren;
	  prddata = 0;
	  ksarddata = q;
	 end else if({initdone, ksadone} == 2'b11) begin
	  addr = paddr;
	  wren = pwren;
	  wrdata = pwrdata;
	  ksarddata = 0;
	  prddata = q;
	 end
	end 
	  

endmodule: arc4
