module tb_mult();

// Your testbench goes here.
logic [31:0] dataa;
logic [31:0] datab;
logic [31:0] result;
logic [8:0] i;
logic clk;
logic reset_n;

mult dut(.*);

initial begin
 clk = 1'b1; #5;
 forever begin
  clk = 1'b0; #5;
  clk = 1'b1; #5;
 end 
end 

initial begin
 reset_n = 1'b1; #5;
 reset_n = 1'b0; #5;
 reset_n = 1'b1;
 dataa = 32'b1;
 datab = 32'b1; 
 for(i = 0; i < 110; i ++) begin
  dataa = dataa + 1;
  datab = datab + 1;
  #1;
  assert(dut.result === dataa * datab);
  #10;
 end
 
 $display("Test Passed");
 $stop();
 end
 
endmodule: tb_mult
