module init(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            output logic [7:0] addr, output logic [7:0] wrdata, output logic wren, output logic done);

// your code here

logic [7:0] i;
logic [8:0] temp;
logic start, protocol;



always_ff @(posedge clk or negedge rst_n) begin
if(rst_n == 1'b0) begin
 rdy = 1'b1;
 protocol = 1'b0;
 start = 1'b0;
end else if(protocol == 1'b0 && en == 1'b1)begin 
 start = 1'b1;
 protocol = 1'b1;
 rdy = 1'b0;
end else if (done == 1'b1) begin
 rdy = 1'b1;
end
end

always_ff @(posedge clk or negedge rst_n) begin
if(rst_n == 1'b0) begin
 i = 8'b11111111;
 temp = 0;
end

else if(start == 1'b1 && done == 1'b0) begin
  i = i + 1;
  temp = temp + 1;
  wren = 1'b1;
  addr = i;
  wrdata = i;
end 

else begin
 wren = 1'b0;
end

end

assign done = (temp == 257);


endmodule: init