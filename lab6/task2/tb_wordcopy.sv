module tb_wordcopy();
logic clk, rst_n;
logic slave_waitrequest;
logic [3:0] slave_address;
logic slave_read, slave_write;
logic [31:0] slave_readdata, slave_writedata;
logic master_waitrequest;
logic [31:0] master_address;
logic master_read, master_write;
logic [31:0] master_readdata, master_writedata;
logic master_readdatavalid;

wordcopy dut(.*);

initial begin
 clk = 1'b0; #1;
 forever begin
  clk = 1'b1; #1;
  clk = 1'b0; #1;
 end
end 

initial begin
 master_readdata = 32'h1000; #5;
 forever begin
  master_readdata = master_readdata + 1'b1; #5;
 end
end


initial begin
 master_waitrequest = 1'b0; #7;
  forever begin
  master_waitrequest = 1'b1; #7;
  master_waitrequest = 1'b0; #7;
  end
end 

initial begin
 master_readdatavalid = 1'b0; #6;
 forever begin
  master_readdatavalid = 1'b1; #6;
  master_readdatavalid = 1'b0; #6;
 end
end

initial begin
//test 1
rst_n = 1'b0; #1;
slave_writedata = 32'b0;
slave_write = 1'b0;
assert(dut.master_read === 1'b0 && dut.master_write === 1'b0); #1;
rst_n = 1'b1; #3;

//destination address
slave_address = 4'd1; 
slave_write = 1'b1;
slave_writedata = 32'ha00; #2;
assert(dut.tempdst === slave_writedata); 

//source address 
slave_address = 4'd2;
slave_write = 1'b1;
slave_writedata = 32'ha80; #2;
assert(dut.tempsrc === slave_writedata);
//number of words
slave_address = 4'd3;
slave_write = 1'b1;
slave_writedata = 32'h10; #2;
assert(dut.number === slave_writedata); 
//start
slave_address = 4'd0;
slave_write = 1'b1;
slave_writedata = 32'h0; #2;
assert(dut.slave_waitrequest === 1'b1);
assert(dut.count === 1'b0);
assert(dut.start === 1'b1);
slave_write = 1'b0;

wait(dut.state === 2);
assert(dut.tempdata === dut.master_readdata);
assert(dut.master_address === dut.tempsrc + dut.count*4);
wait(master_write === 1'b1);
assert(dut.master_writedata === dut.tempdata);
assert(dut.master_address === dut.tempdst + dut.count*4);
wait(slave_waitrequest === 1'b0);
#20;
assert(dut.start === 1'b0);
assert(dut.slave_waitrequest === 1'b0);
assert(dut.count === dut.number);
assert(dut.master_read === 1'b0 && dut.master_write === 1'b0);

$display("Test1 Passed");
//test 2
//source address
slave_address = 4'd2;
slave_write = 1'b1;
slave_writedata = 32'h800; #2;
assert(dut.tempsrc === dut.slave_writedata); 
//destination address
slave_address = 4'd1;
slave_write = 1'b1;
slave_writedata = 32'h890; #2;
assert(dut.tempdst === dut.slave_writedata); 
//number of words 
slave_address = 4'd3;
slave_write = 1'b1;
slave_writedata = 32'h4; #2;
assert(dut.number === dut.slave_writedata);
//start 
slave_address = 4'd0;
slave_write = 1'b1;
slave_writedata = 32'h0; #2;
assert(dut.slave_waitrequest === 1'b1);
assert(dut.count === 1'b0);
assert(dut.start === 1'b1);
slave_write = 1'b0;

wait(dut.state === 2);
assert(dut.tempdata === dut.master_readdata);
assert(dut.master_address === dut.tempsrc + dut.count*4);
wait(master_write === 1'b1);
assert(dut.master_writedata === dut.tempdata);
assert(dut.master_address === dut.tempdst + dut.count*4);
wait(slave_waitrequest === 1'b0);
#20;
assert(dut.start === 1'b0);
assert(dut.slave_waitrequest === 1'b0);
assert(dut.count === dut.number);
assert(dut.master_read === 1'b0 && dut.master_write === 1'b0);

$display("Test2 Passed");
$stop;
end
endmodule: tb_wordcopy

