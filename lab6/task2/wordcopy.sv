module wordcopy(input logic clk, input logic rst_n,
                // slave (CPU-facing)
                output logic slave_waitrequest,
                input logic [3:0] slave_address,
                input logic slave_read, output logic [31:0] slave_readdata,
                input logic slave_write, input logic [31:0] slave_writedata,
                // master (SDRAM-facing)
                input logic master_waitrequest,
                output logic [31:0] master_address,
                output logic master_read, input logic [31:0] master_readdata, input logic master_readdatavalid,
                output logic master_write, output logic [31:0] master_writedata);

    // your code here
logic [31:0] tempdst, tempsrc, number;
logic [31:0] tempdata;
logic [31:0] count;
logic start, protocol, done;
logic [3:0] state;
parameter
init = 3'b000,
readvalid = 3'b001,
write = 3'b010,
iterate = 3'b011;

    always@(posedge clk or negedge rst_n) begin
	 if(!rst_n) begin
	  master_read = 1'b0;
	  master_write = 1'b0;
	  count = 0;
	  start = 0;
	  slave_waitrequest = 1'b1;
	 end else if(start == 1'b0) begin
	  slave_waitrequest = 1'b0;
	  if(slave_write && slave_address == 1) begin
	   tempdst = slave_writedata;
	  end else if(slave_write && slave_address == 2) begin
	   tempsrc = slave_writedata;
	  end else if(slave_write && slave_address == 3) begin
	   number = slave_writedata;
	  end else if(slave_write && slave_address == 0) begin
	   start = 1'b1; 
	   state <= init;//start the copy process
	   count = 0;
	   slave_waitrequest = 1'b1;
	  end
	 end else if(start == 1'b1 && done == 1'b0) begin
	   case(state)
	   
	   init:
	   begin
	    master_read = 1'b1;
		master_write = 1'b0;
		master_address = tempsrc + count * 4;
	    if(master_waitrequest == 1'b1) begin
	     state <= init;
		end else begin		 		 
		 state <= readvalid;
		end 
	   end 
	   
	   readvalid: 
	   begin
	    master_read = 1'b0;
		if(master_readdatavalid == 1'b1) begin
	     tempdata = master_readdata; 
	     state <= write;
	    end else begin
	     state <= readvalid;
	    end
	   end
	   
	   write:
	   begin
	    master_write = 1'b1;
		master_address = tempdst + count * 4;
		master_writedata = tempdata;
		if(master_waitrequest == 1'b1) begin
		 state <= write;
		end else begin
		 state <= iterate;
		end 
	   end 
	   
	   iterate:
	   begin 
	    master_write = 1'b0;
		count = count + 1;
		state <= init;
	   end 
	   
	   endcase
	  end else if(start == 1'b1 && done == 1'b1) begin
	   start = 1'b0;
	   master_read = 1'b0;
	   master_write = 1'b0;
	   slave_waitrequest = 1'b0;
	  end 
	end  
	  
	 assign done = (count < number) ? 1'b0 : 1'b1;
	 
endmodule: wordcopy
