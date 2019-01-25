module init(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            output logic [7:0] addr, output logic [7:0] wrdata, output logic wren, output logic done);

// your code here

logic [7:0] i;
logic [8:0] temp;
logic start, protocol;
logic [2:0] count;


always_ff @(posedge clk or negedge rst_n) begin
if(rst_n == 1'b0) begin
 rdy = 1'b1;
 i = 0;
 addr = 0;
 wrdata = 0;
 wren = 0;
 count = 0;
 temp = 0;
 done = 0;
end else begin 
 if(count == 0) begin
  if(en == 0) begin
   rdy = 1;
   i = 0;
   temp = 0;
   wrdata = 0;
   wren = 0;
   addr = 0;
  end else begin
   rdy = 0;
   addr = i;
   wrdata = i;
   wren = 1;
   i = i + 1;
   temp = temp + 1;
   count = count + 1;
  end
 end else if(count == 1) begin
  if(temp <= 255) begin
   addr = i;
   wrdata = i;
   wren = 1;
   i = i + 1;
   temp = temp + 1;
  end else begin
   done = 1;
   rdy = 1;
   i = 0;
   addr = 0;
   wrdata = 0;
   wren = 0;
   count = count + 1;
  end
 end else if(count == 2) begin
  rdy = 1;
  i = 0;
  wrdata = 0;
  wren = 0;
  addr = 0;
  count = 2;
 end else begin
  count = 0;
 end
end
end

endmodule: init