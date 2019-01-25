module chipmunks(input CLOCK_50, input CLOCK2_50, input [3:0] KEY, input [9:0] SW,
                 input AUD_DACLRCK, input AUD_ADCLRCK, input AUD_BCLK, input AUD_ADCDAT,
                 inout FPGA_I2C_SDAT, output FPGA_I2C_SCLK, output AUD_DACDAT, output AUD_XCK,
                 output [6:0] HEX0, output [6:0] HEX1, output [6:0] HEX2,
                 output [6:0] HEX3, output [6:0] HEX4, output [6:0] HEX5,
                 output [9:0] LEDR);
			
// signals that are used to communicate with the audio core
// DO NOT alter these -- we will use them to test your design

reg read_ready, write_ready, write_s;
reg [15:0] writedata_left, writedata_right;
reg [15:0] readdata_left, readdata_right;	
wire reset, read_s;

// signals that are used to communicate with the flash core
// DO NOT alter these -- we will use them to test your design

reg flash_mem_read;
reg flash_mem_waitrequest;
reg [22:0] flash_mem_address;
reg [31:0] flash_mem_readdata;
reg flash_mem_readdatavalid;
reg [3:0] flash_mem_byteenable;
reg rst_n, clk;

// DO NOT alter the instance names or port names below -- we will use them to test your design

clock_generator my_clock_gen(CLOCK2_50, reset, AUD_XCK);
audio_and_video_config cfg(CLOCK_50, reset, FPGA_I2C_SDAT, FPGA_I2C_SCLK);
audio_codec codec(CLOCK_50,reset,read_s,write_s,writedata_left, writedata_right,AUD_ADCDAT,AUD_BCLK,AUD_ADCLRCK,AUD_DACLRCK,read_ready, write_ready,readdata_left, readdata_right,AUD_DACDAT);
flash flash_inst(.clk_clk(clk), .reset_reset_n(rst_n), .flash_mem_write(1'b0), .flash_mem_burstcount(1'b1),
                 .flash_mem_waitrequest(flash_mem_waitrequest), .flash_mem_read(flash_mem_read), .flash_mem_address(flash_mem_address),
                 .flash_mem_readdata(flash_mem_readdata), .flash_mem_readdatavalid(flash_mem_readdatavalid), .flash_mem_byteenable(flash_mem_byteenable), .flash_mem_writedata());

// your code for the rest of this task here
//logic parameters
logic [31:0] inputmusic;
logic signed [15:0] hsample, lsample;
logic signed [15:0] sf;
logic [1:0] tune;
assign sf = 16'd64;
assign flash_mem_byteenable = 4'b1111;
assign read_s = 1'b0;
assign tune = SW[1:0];

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

logic [3:0] state;

assign clk = CLOCK_50;
assign rst_n = KEY[3];
assign reset = ~(KEY[3]);

always @(posedge clk or negedge rst_n) begin

 if(!rst_n) begin
  flash_mem_address = 23'b0; 
  flash_mem_read = 1'b0;
  
  state <= init;
 end else begin
  case(state)
  
   init: 
   begin
    flash_mem_address = 23'b0; 
    flash_mem_read = 1'b1;
	write_s <= 1'b0;
	state <= request;
   end 
   
   request:
   begin
    if(flash_mem_waitrequest == 1'b1) begin
	 state <= request; 
	end else begin
	 state <= read_data_valid;
	end 
   end 
   
   read_data_valid:
   begin
	if(flash_mem_readdatavalid == 1'b1) begin
	 flash_mem_read = 1'b0;
	 inputmusic = flash_mem_readdata; 
	 hsample = inputmusic[31:16]; //select the higher bit
	 lsample = inputmusic[15:0]; //select the lower bit
	 if(tune == 2'b00 || tune == 2'b11) begin //play at normal speed
	  state <= wait_for_ready_low;
    end else if(tune == 2'b01) begin
	  state <= wait_for_ready_high; //play at faster speed
	 end else begin
	  state <= wait_for_ready_low; //play at slower speed
	 end
	end else begin
	 state <= read_data_valid;
	end
   end
   
   wait_for_ready_low:
   begin
    write_s <= 1'b0;                //set write_s to 0, and wait for write_ready to become 1
	if(write_ready == 1'b1) begin
	 state <= get_music_bit_low;    //codec is ready for the one signal sample
	end else begin
	 state <= wait_for_ready_low;
	end 
   end 
   
   get_music_bit_low:
   begin  	
	writedata_right <= lsample / sf;
	writedata_left <= lsample / sf;	
	write_s <= 1'b1;
	if(write_ready == 1'b0) begin
	 if(tune == 2'b10) begin //play at lower speed
	  state <= repeat_wait_low;
	 end else begin
	  state <= wait_for_ready_high;
	 end
	end else begin
	 state <= get_music_bit_low;
	end
   end
   
   repeat_wait_low:
   begin
    write_s <= 1'b0;                //set write_s to 0, and wait for write_ready to become 1
	if(write_ready == 1'b1) begin
	 state <= repeat_music_low;         //codec is ready for the one signal sample
	end else begin
	 state <= repeat_wait_low;
	end 
   end
   
   repeat_music_low:
   begin
    writedata_right <= lsample / sf;
	writedata_left <= lsample / sf;	
	write_s <= 1'b1;
	if(write_ready == 1'b0) begin
	 if(tune == 2'b10) begin //play at lower speed
	  state <= wait_for_ready_high;
	 end else begin
	  state <= wait_for_ready_high;
	 end
	end else begin
	 state <= repeat_music_low;
	end
	end
 
   wait_for_ready_high:
   begin
    write_s <= 1'b0;
    if(write_ready == 1'b1) begin
	 state <= get_music_bit_high;
	end else begin
	 state <= wait_for_ready_high;
	end 
   end
   
   get_music_bit_high:
   begin
    write_s <= 1'b1;
	writedata_right <= hsample / sf;
	writedata_left <= hsample / sf;	
	if(write_ready == 1'b0) begin
	 if(tune == 2'b10) begin
	  state <= repeat_wait_high;
	 end else begin
	  state <= iterate;
	 end
	end else begin
	 state <= get_music_bit_high;
	end
   end
   
   repeat_wait_high:
   begin
	write_s <= 1'b0;
    if(write_ready == 1'b1) begin
	 state <= repeat_music_high;
	end else begin
	 state <= repeat_wait_high;
	end 
   end
   
   repeat_music_high:
   begin
   write_s <= 1'b1;
	writedata_right <= hsample / sf;
	writedata_left <= hsample / sf;	
	if(write_ready == 1'b0) begin
	  state <= iterate;
	end else begin
	 state <= repeat_music_high;
	end
   end
    
   iterate:
   begin
    flash_mem_read = 1'b1;
	write_s <= 1'b0;
	if(flash_mem_address < 23'h200000/2) begin
	 flash_mem_address = flash_mem_address + 23'b1;
	end else begin
	 flash_mem_address = 23'b0;
	end 
	state <= request;
   end

   
   default: 
   begin
    state <= request;
   end 
   
  endcase
  end
  
 end 
 
endmodule: chipmunks
