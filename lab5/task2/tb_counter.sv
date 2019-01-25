module tb_counter();

// Your testbench goes here.
logic [3:0] address;
logic clk;
logic reset_n;
logic read;
logic [31:0] readdata;

counter dut(.*);

initial begin
clk = 1'b1; #5;
 forever begin
  clk = 1'b0; #5;
  clk = 1'b1; #5;
 end 
end

initial begin
 reset_n = 1'b1; #5;
 reset_n = 1'b0; 
 address = 4'b0; 
 read = 1'b0;    #5;
 reset_n = 1'b1; #5;
 read = 1'b1;    #5;
 read = 1'b1; #1;
 assert(dut.readdata === dut.count[31:0]);
 #9;
 read = 1'b0;
 address = 4'b0010; #5;
 read = 1'b1; #6;
 assert(dut.readdata === dut.count[63:32]);
 #10;
 address = 4'b1000; #6;
 assert(dut.readdata === dut.count[63:32]);
 #10;
 address = 4'b0000; #6;
 assert(dut.readdata === dut.count[31:0]);
 #10;
$display("Test Passed");
$stop();
end 

endmodule: tb_counter
