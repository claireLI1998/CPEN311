`timescale 1ps / 1ps
module tb_chipmunks();
							
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
						
parameter
init = 4'b0000,
request = 4'b0001,
read_data_valid = 4'b0010,
wait_for_ready_low = 4'b0011,
get_music_bit_low = 4'b0100,
repeat_wait_low = 4'b0101,
repeat_music_low = 4'b0110,
repeat_wait_high = 4'b0111,
repeat_music_high = 4'b1000,
wait_for_ready_high = 4'b1001,
get_music_bit_high = 4'b1010,
iterate = 4'b1011;

chipmunks dut(.*);
                             
initial begin
  CLOCK_50 = 1'b0; #5;
 forever begin
  CLOCK_50 = 1'b1; #5;
  CLOCK_50 = 1'b0; #5;
 end 
end 
				
initial begin						
i = 0;
SW[1:0] = 2'b01;
KEY[3] = 1'b1;#5;
KEY[3] = 1'b0;#5;
KEY[3] = 1'b1;#9030;

SW[1:0] = 2'b00;
KEY[3] = 1'b1;#5;
KEY[3] = 1'b0;#5;
KEY[3] = 1'b1;#15005;

SW[1:0] = 2'b11;
KEY[3] = 1'b1;#5;
KEY[3] = 1'b0;#5;
KEY[3] = 1'b1;#15005;

SW[1:0] = 2'b10;
KEY[3] = 1'b1;#5;
KEY[3] = 1'b0;#5;
KEY[3] = 1'b1;#15005;

$stop;
end    
									
initial begin
 #6;
 assert(dut.state === 0 &&
        dut.tune === 2'b01 &&
		dut.write_ready === 1'b0 &&
	    dut.flash_mem_read === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === 0);
 #10; //16
for(i = 0; i < 100; i ++) begin
 assert(dut.state === 1);
 assert(dut.write_s === 1'b0);
 assert(dut.flash_mem_read === 1'b1);
 assert(dut.flash_mem_waitrequest === 1'b0);
 assert(dut.flash_mem_readdatavalid === 1'b0);
 assert(dut.flash_mem_address === i);
 #10; //26
 assert(dut.state === 2 &&
        dut.tune === 2'b01 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_read === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //36
 assert(dut.state === 2 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10;
 assert(dut.state === 2 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b1 &&
		dut.flash_mem_address === i);
 #10;
 assert(dut.state === 9 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;
 assert(dut.state === 10 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;		
 assert(dut.state === 10 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;			
 assert(dut.state === 10 &&
        dut.tune === 2'b01 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;	
 assert(dut.state === 11 &
        dut.tune === 2'b01 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;
end 
$display("Test1 passed");	
end


initial begin
#9046;
assert(dut.state === 0 &&
        dut.tune === 2'b00 &&
		dut.write_ready === 1'b0 &&
	    dut.flash_mem_read === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === 0);
 #10; //9056
for(i = 0; i < 100; i ++) begin
 assert(dut.state === 1);
 assert(dut.write_s === 1'b0);
 assert(dut.flash_mem_read === 1'b1);
 assert(dut.flash_mem_waitrequest === 1'b0);
 assert(dut.flash_mem_readdatavalid === 1'b0);
 assert(dut.flash_mem_address === i);
 #10; //9066
 assert(dut.state === 2 &&
        dut.tune === 2'b00 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_read === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9076
 assert(dut.state === 2 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9086
 assert(dut.state === 2 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b1 &&
		dut.flash_mem_address === i);
 #10; //9096
 assert(dut.state === 3 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9106
 assert(dut.state === 4 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9116
 assert(dut.state === 4 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9126
 assert(dut.state === 4 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;		//9136
 assert(dut.state === 9 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.lsample/64 &&
		dut.writedata_right === dut.lsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #20;	//9156		
 assert(dut.state === 9 &&
        dut.tune === 2'b00 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.lsample/64 &&
		dut.writedata_right === dut.lsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #20;	//9176
 assert(dut.state === 10 &
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9186
 assert(dut.state === 10 &
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9196
 assert(dut.state === 11 &
        dut.tune === 2'b00 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;
end
$display("Test2 passed");
end

initial begin
#24061;
assert(dut.state === 0 &&
        dut.tune === 2'b11 &&
		dut.write_ready === 1'b0 &&
	    dut.flash_mem_read === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === 0);
 #10; //9056
for(i = 0; i < 100; i ++) begin
 assert(dut.state === 1);
 assert(dut.write_s === 1'b0);
 assert(dut.flash_mem_read === 1'b1);
 assert(dut.flash_mem_waitrequest === 1'b0);
 assert(dut.flash_mem_readdatavalid === 1'b0);
 assert(dut.flash_mem_address === i);
 #10; //9066
 assert(dut.state === 2 &&
        dut.tune === 2'b11 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_read === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9076
 assert(dut.state === 2 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b1 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9086
 assert(dut.state === 2 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b1 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b1 &&
		dut.flash_mem_address === i);
 #10; //9096
 assert(dut.state === 3 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9106
 assert(dut.state === 4 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.flash_mem_address === i);
 #10; //9116
 assert(dut.state === 4 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9126
 assert(dut.state === 4 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;		//9136
 assert(dut.state === 9 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.lsample/64 &&
		dut.writedata_right === dut.lsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #20;	//9156		
 assert(dut.state === 9 &&
        dut.tune === 2'b11 &&
		dut.write_s === 1'b0 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.lsample/64 &&
		dut.writedata_right === dut.lsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #20;	//9176
 assert(dut.state === 10 &
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b1 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9186
 assert(dut.state === 10 &
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10; //9196
 assert(dut.state === 11 &
        dut.tune === 2'b11 &&
		dut.write_s === 1'b1 &&
		dut.flash_mem_read === 1'b0 &&
		dut.write_ready === 1'b0 &&
		dut.flash_mem_waitrequest === 1'b0 &&
		dut.flash_mem_readdatavalid === 1'b0 &&
		dut.hsample === dut.inputmusic[31:16] &&
		dut.lsample === dut.inputmusic[15:0] &&
		dut.writedata_left === dut.hsample/64 &&
		dut.writedata_right === dut.hsample/64 &&
		dut.inputmusic === dut.flash_mem_readdata &&
		dut.flash_mem_address === i);
 #10;
end
$display("Test3 passed");
end
 

endmodule: tb_chipmunks

// Any other simulation-only modules you need
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

module flash(input logic clk_clk, input logic reset_reset_n,
             input logic flash_mem_write, input logic [6:0] flash_mem_burstcount,
             output logic flash_mem_waitrequest, input logic flash_mem_read,
             input logic [22:0] flash_mem_address, output logic [31:0] flash_mem_readdata,
             output logic flash_mem_readdatavalid, input logic [3:0] flash_mem_byteenable,
             input logic [31:0] flash_mem_writedata);
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
