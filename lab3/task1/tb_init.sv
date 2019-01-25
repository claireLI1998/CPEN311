module tb_init();

// Your testbench goes here.
logic clk, rst_n, en, rdy, wren;
logic [7:0] addr, wrdata;
logic [7:0] i;
logic [8:0] temp;

init dut(.*);
initial begin
clk = 1'b0; #5;
forever begin
clk = 1'b1; #5;
clk = 1'b0; #5;
end
end

initial begin

en = 1;
rst_n = 1'b0;#5;
en = 1;
rst_n = 1'b0;#5;
assert(rdy === 1'b1) en = 1; 
else en = 0; 
rst_n = 1'b1;#5;
en = 0;
rst_n = 1'b1;#5;

assert(addr === 0);
assert(wrdata === 0);
assert(wren === 1);
en = 0;
rst_n = 1;
i = 1;
for(temp = 1; temp < 256; temp ++) begin
 #10;
 assert(addr === i);
 assert(wrdata === i);
 assert(wren === 1);
 i ++;
end

$display("Test passed");

$stop;
end

endmodule: tb_init