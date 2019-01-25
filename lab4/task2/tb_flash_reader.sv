`timescale 1ps / 1ps
module tb_flash_reader();

// Your testbench goes here.
logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] SW;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [8:0] i;
logic [8:0] index;
flash_reader dut(.*);

initial begin
 CLOCK_50 = 1'b1; #5;
 forever begin
  CLOCK_50 = 1'b0; #5;
  CLOCK_50 = 1'b1; #5;
 end 
end 

initial begin
 
 KEY[3] = 1'b1; #5;
 KEY[3] = 1'b0; #5;
 KEY[3] = 1'b1; #1;
 index = 0;
 for(i = 0; i < 128; i ++) begin
  //11ps
  
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_readdatavalid === 1'b0);
  assert(dut.flash_mem_waitrequest === 1'b0);
  
  //21ps
  #10;
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_read === 1'b1);
  assert(dut.flash_mem_waitrequest === 1'b0);
  assert(dut.flash_mem_readdatavalid === 1'b0);
  
  //31ps
  #10;
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_read === 1'b1);
  assert(dut.flash_mem_waitrequest === 1'b1);
  assert(dut.flash_mem_readdatavalid === 1'b0);
  
  //41ps
  #10;
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_read === 1'b1);
  assert(dut.flash_mem_waitrequest === 1'b1);
  assert(dut.flash_mem_readdatavalid === 1'b0);
  
  //51ps
  #10;
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_read === 1'b1);
  assert(dut.flash_mem_waitrequest === 1'b0);
  assert(dut.flash_mem_readdatavalid === 1'b1);
  
  //61ps
  #10;
  assert(dut.flash_mem_address === i);
  assert(dut.flash_mem_read === 1'b0);
  assert(dut.flash_mem_waitrequest === 1'b0);
  assert(dut.flash_mem_readdatavalid === 1'b0);
  assert(dut.wren === 1'b1);
  assert(dut.data === dut.rddata[15:0]);
  assert(dut.addr === index);
  index = index + 1;
  //71ps
  #10;
  assert(dut.wren === 1'b1);
  assert(dut.data === dut.rddata[31:16]);
  assert(dut.addr === index);
  index = index + 1;
  #10;
  
 end
 
 $display("Test passed");
 $stop;
 end

endmodule: tb_flash_reader

module flash(input logic clk_clk, input logic reset_reset_n,
             input logic flash_mem_write, input logic [6:0] flash_mem_burstcount,
             output logic flash_mem_waitrequest, input logic flash_mem_read,
             input logic [22:0] flash_mem_address, output logic [31:0] flash_mem_readdata,
             output logic flash_mem_readdatavalid, input logic [3:0] flash_mem_byteenable,
             input logic [31:0] flash_mem_writedata);

// Your simulation-only flash module goes here.
parameter
start = 3'b000,
one_cycle = 3'b001,
send_valid = 3'b010,
wait_accepted = 3'b011,
wait_1 = 3'b100,
finish = 3'b101;


logic [1:0] state;
logic [31:0] dataout;

always @(posedge clk_clk or negedge reset_reset_n) begin
 if(!reset_reset_n) begin
  flash_mem_waitrequest = 1'b0;
  flash_mem_readdatavalid = 1'b0;
  dataout = 32'b0;
  state <= start;
 end else begin
  case(state)
  
  start:
  begin
   flash_mem_readdatavalid = 1'b0;
   if(flash_mem_read == 1'b1) begin
    flash_mem_waitrequest = 1'b1;
	state <= one_cycle;
   end else begin
    flash_mem_waitrequest = 1'b0;
	state <= start;
   end 
  end
  
  one_cycle: //waitrequest signal is set high and wait for one more cycle
  begin
   flash_mem_waitrequest = 1'b1;
   dataout = {9'b10, flash_mem_address};
   state <= send_valid;
  end
  
  send_valid:
  begin
   flash_mem_waitrequest = 1'b0;
   if(dataout != 32'b0) begin
    flash_mem_readdatavalid = 1'b1;
	flash_mem_readdata = dataout;
	state <= wait_accepted;
   end else begin
    flash_mem_readdatavalid = 1'b0;
	state <= send_valid;
   end
  end
  
  wait_accepted:
  begin
    flash_mem_readdatavalid = 1'b0;
    state = wait_1;
  end
  
  wait_1:
  begin
   state = finish;
  end 
  
  finish:
  begin
   state <= start;
  end 
  
  default: 
  begin
   flash_mem_waitrequest = 1'b0;
   flash_mem_readdatavalid = 1'b0;
  end

endcase

end
 
end

endmodule: flash
