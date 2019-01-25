module fillscreen(input logic clk, input logic rst_n, input logic [2:0] colour,
                  input logic start, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);
     // fill the screen

parameter xMax = 160; 
parameter yMax = 120; 

logic plot, xend, yend;
logic [7:0] x;
logic [6:0] y;

//always @(*) begin
//if(x != (xMax - 1)) begin
// xend = 1'b0;
//end else begin 
// xend = 1'b1;
//end
//if (y != (yMax - 1)) begin
// yend = 1'b0;
//end else begin
// yend = 1'b1;
//end
//done = xend & yend;
//end

always_ff @(posedge clk or negedge rst_n) begin
if(rst_n == 1'b0) begin
x = 0;
y = 7'b1111111;
plot = 0;
end else if(done == 1'b0 && start == 1'b1) begin
 if(y != (yMax - 1)) begin
  y = y + 1;
  plot = 1;  
 end else begin
  x = x + 1;
  y = 0;
  plot = 1;
 end
end else begin
 plot = 0;
end
end

assign done = (vga_x == 159)&&(vga_y == 119);
assign vga_colour = x % 4'b1000;
assign vga_plot = plot;
assign vga_x = x;
assign vga_y = y;

endmodule


