module counter(input logic clk, input logic reset_n,
               input logic [3:0] address, input logic read, output logic [31:0] readdata);

// your code here
logic [63:0] count;

always@(posedge clk or negedge reset_n) begin
 if(!reset_n) begin
  count = 64'b0;
 end else begin
  count = count + 1;
  if(read == 1'b1) begin
   if(address == 4'b0000) begin
    readdata <= count[31:0];
   end else begin
    readdata <= count[63:32];
   end 
  end
 end
end

endmodule: counter