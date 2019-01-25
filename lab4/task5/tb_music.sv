`timescale 1ps / 1ps
module tb_music();
logic CLOCK_50;
logic CLOCK2_50;
logic [3:0] KEY;
logic [9:0] SW;
logic AUD_DACLRCK; 
logic AUD_ADCLRCK;
logic AUD_BCLK; 
logic AUD_ADCDAT;
wire FPGA_I2C_SDAT;
wire FPGA_I2C_SCLK;
logic AUD_DACDAT;
logic AUD_XCK;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [8:0] i;
// Your testbench goes here.

music dut(.*);

initial begin
 CLOCK_50 = 1'b0; #5;
 forever begin
  CLOCK_50 = 1'b1; #5;
  CLOCK_50 = 1'b0; #5;
 end 
end 

initial begin
 i = 0;
 KEY[3] = 1'b1; #5;
 KEY[3] = 1'b0; #5;
 KEY[3] = 1'b1; #1;

end

initial begin
#6;
assert(dut.reset === 1'b1);
assert(dut.write_ready === 1'b0);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === 0);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.state === 0);

#10; //16ps
for(i = 0; i < 128; i ++) begin

//assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b1);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.state === 1);
#10;//26 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b1);
assert(dut.flash_mem_waitrequest === 1'b1);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.state === 2);
#20;//46 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b1);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b1);
assert(dut.state === 2);
#10; //56 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.state === 3);
#10; //66 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.state === 4);
#10; //76 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b1);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.lsample/64);
assert(dut.writedata_right === dut.lsample/64);
assert(dut.state === 4);
#10; //86 ps

assert(dut.write_ready === 1'b0);
assert(dut.write_s === 1'b1);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.lsample/64);
assert(dut.writedata_right === dut.lsample/64);
assert(dut.state === 4);
#10; //96 ps

assert(dut.write_ready === 1'b0);
assert(dut.write_s === 1'b1);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.lsample/64);
assert(dut.writedata_right === dut.lsample/64);
assert(dut.state === 5);
#10; //106 ps

assert(dut.write_ready === 1'b0);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.lsample/64);
assert(dut.writedata_right === dut.lsample/64);
assert(dut.state === 5);
#10; //116 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b0);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.lsample/64);
assert(dut.writedata_right === dut.lsample/64);
assert(dut.state === 5);
#20; //136 ps

assert(dut.write_ready === 1'b1);
assert(dut.write_s === 1'b1);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.hsample/64);
assert(dut.writedata_right === dut.hsample/64);
assert(dut.state === 6);
#20; //136 ps

assert(dut.write_ready === 1'b0);
assert(dut.write_s === 1'b1);
assert(dut.flash_mem_read === 1'b0);
assert(dut.flash_mem_waitrequest === 1'b0);
assert(dut.flash_mem_address === i);
assert(dut.flash_mem_readdatavalid === 1'b0);
assert(dut.inputmusic === dut.flash_mem_readdata);
assert(dut.hsample === dut.inputmusic[31:16]);
assert(dut.lsample === dut.inputmusic[15:0]);
assert(dut.writedata_left === dut.hsample/64);
assert(dut.writedata_right === dut.hsample/64);
assert(dut.state === 7);
#10; //166 ps
end
$display("Test passed");
$stop;
end


endmodule: tb_music

// Any other simulation-only modules you need

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
   dataout = {9'b011110, flash_mem_address};
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

module clock_generator (input logic CLOCK2_50, input logic reset, output logic AUD_XCK);

endmodule: clock_generator

module audio_and_video_config (input logic CLOCK_50, input logic reset, wire I2C_SDAT, output logic I2C_SCLK); 


endmodule: audio_and_video_config

module audio_codec (input logic CLOCK_50, input logic reset, input logic read_s, 
					input logic write_s, input logic [15:0] writedata_left, 
					input logic [15:0] writedata_right, input logic AUD_ADCDAT, 
					input logic AUD_BCLK, input logic AUD_ADCLRCK, input logic AUD_DACLRCK,
					output logic read_ready, write_ready, output logic [15:0] readdata_left,
					output logic [15:0] readdata_right, 
					output logic AUD_DACDAT);


always@(posedge CLOCK_50 or posedge reset) begin
 if(reset == 1'b1) begin
   write_ready = 1'b0;   
 end else begin
  if(write_s == 1'b1) begin
   write_ready = 1'b0;
  end else begin
   write_ready = 1'b1;
  end 
end

end
endmodule: audio_codec