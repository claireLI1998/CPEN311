module tb_ksa();

// Your testbench goes here.
logic clk;
logic rst_n;
logic en, rdy;
logic [23:0] key;
logic [7:0] addr;
logic [7:0] rddata;
logic [7:0] wrdata;
logic [8:0] im, c;
logic wren;

ksa dut(.*);

initial begin
 clk = 1'b1; #5;
 forever begin
  clk = 1'b0; #5;
  clk = 1'b1; #5;
 end
end 

initial begin
 en = 0;
 rst_n = 1'b1; #5;
 rst_n = 1'b0; #5;
 rst_n = 1'b1;
 
 en = 1'b1; #5;
 en = 1'b0;

 
 end
 
 initial begin
 #105;
 c = 1;
 for(im = 1; im < 256; im ++) begin
 assert(dut.count === c);
 assert(dut.addr === (dut.i - 1));
 assert(dut.i === im);
 assert(dut.wren === 1);
 c = c + 1;
 #10;
 assert(dut.addr === dut.i);
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 c = c + 1;
 #10;
 assert(dut.count === c);
 assert(dut.wren === 1);
 c = 1;
 #10;
 end
 $display("Test passed");
 $stop;
 end
 
endmodule: tb_ksa
