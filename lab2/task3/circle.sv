module circle(input logic clk, input logic rst_n, input logic [2:0] colour,
              input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] radius,
              input logic start, output logic done,
              output logic [7:0] vga_x, output logic [6:0] vga_y,
              output logic [2:0] vga_colour, output logic vga_plot);
     // draw the circle
	logic [4:0] temp;
	logic [7:0] offset_x;
	logic [6:0] offset_y;
	logic signed [8:0] x;
	logic signed [7:0] y;
	logic plot;
	logic signed [8:0] crit;
	
	always@(*)begin
    if(offset_y <= offset_x)begin
	 done = 1'b0;
	end else begin
	 done = 1'b1;
	end
	end 
	
	always_ff @(posedge clk or negedge rst_n) begin
	 if(rst_n == 1'b0) begin
	  offset_y = 1'b0;
	  offset_x = radius;
	  crit = 1 - radius;
	  temp = 1'b1;
	 end else if(done == 1'b0 && start == 1'b1)begin
	  if(temp == 1) begin
	   x = centre_x + offset_x;
	   y = centre_y + offset_y;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 2) begin
	   x = centre_x + offset_y;
	   y = centre_y + offset_x;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 4) begin
	   x = centre_x - offset_x;
	   y = centre_y + offset_y;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 3) begin
	   x = centre_x - offset_y;
	   y = centre_y + offset_x;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 5) begin
	   x = centre_x - offset_x;
	   y = centre_y - offset_y;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 6) begin
	   x = centre_x - offset_y;
	   y = centre_y - offset_x;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 7) begin
	   x = centre_x + offset_x;
	   y = centre_y - offset_y;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 8) begin
	   x = centre_x + offset_y;
	   y = centre_y - offset_x;
	   if((x[8] != 1) && (y[7] != 1) && (x[7:0] <160) && (y[6:0] < 120)) begin
	    plot = 1'b1;
	   end else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 9) begin
       offset_y = offset_y + 1;
	   temp = temp + 1;
	  end else begin  
	   if((crit[8] == 1'b1) ^ (crit == 0))begin
	    crit = crit + 2*offset_y + 1;
	   end else begin
	    offset_x = offset_x - 1;
	    crit = crit + 2*(offset_y - offset_x) + 1;
	   end
	   temp = 1;
	  end
	 end else begin
	  plot = 1'b0;
	 end
	
	 end
	  
assign vga_x = x[7:0];
assign vga_y = y[6:0];
assign vga_plot = plot;
assign vga_colour = colour;	 
	   
endmodule

module clearscreen(input logic clk, input logic rst_n, input logic [2:0] colour,
                  input logic start, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);
     // fill the screen

parameter xMax = 160; 
parameter yMax = 120; 

logic plot, xend, yend;
logic [7:0] x;
logic [6:0] y;

always @(*) begin
if(x != (xMax - 1)) begin
 xend = 1'b0;
end else begin 
 xend = 1'b1;
end
if (y != (yMax - 1)) begin
 yend = 1'b0;
end else begin
 yend = 1'b1;
end
done = xend & yend;
end

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

assign vga_colour = colour;
assign vga_plot = plot;
assign vga_x = x;
assign vga_y = y;

endmodule
