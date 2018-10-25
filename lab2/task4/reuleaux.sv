module reuleaux(input logic clk, input logic rst_n, input logic [2:0] colour,
                input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] diameter,
                input logic start, output logic done,
                output logic [7:0] vga_x, output logic [6:0] vga_y,
                output logic [2:0] vga_colour, output logic vga_plot);
     // draw the Reuleaux triangle
	logic signed [8:0] x1, x2, x3, bx1, bx2;
	logic signed [7:0] y1, y2, y3, by1, by2;
	logic [1:0] i;
	logic [4:0] temp;
	logic [7:0] offset_x, halfd, co;
	logic [6:0] offset_y;
	logic signed [8:0] x;
	logic signed [7:0] y;
	logic plot;
	logic [7:0] sqrt, num;
	logic [15:0] constant, length;
	logic signed [8:0] crit;
	
	assign sqrt = 8'b100101;
	assign constant = sqrt * diameter; //80/sqrt3
	assign length = sqrt * halfd; //40/sqrt3
	assign num = constant[5] ? constant[13:6] + 1 : constant[13:6]; //80/sqrt3
    assign co = length[5] ? length[13:6] + 1 : length[13:6]; //40/sqrt3
	assign halfd = diameter >> 1'b1; //40

	assign x1 = centre_x - halfd;
	assign y1 = centre_y + co;
	assign x2 = centre_x;
	assign y2 = centre_y - num;
	assign x3 = centre_x + halfd;
	assign y3 = centre_y + co;
	
	assign vga_x = x[7:0];
    assign vga_y = y[6:0];
    assign vga_plot = plot;
    assign vga_colour = colour;	
	
	
	
	always_ff @(posedge clk or negedge rst_n) begin
     if(rst_n == 1'b0) begin //5
	  offset_y = 1'b0;
	  offset_x = diameter;
	  crit = 1 - diameter;
	  done = 1'b0;
	  i = 1'b1;
	  temp = 1'b1;                       
	 end //5
	 else if(done == 1'b0 && start == 1'b1)begin //4
	 
	 if(i == 1) begin // the first circle
	   bx1 = x2;
	   by1 = y2;
	   bx2 = x3;
	   by2 = y3;
	   if(offset_y <= offset_x)begin //while offset_x1 <= offset_y1
	  if(temp == 1) begin
	   x = x1 + offset_x;
	   y = y1 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 2) begin
	   x = x1 + offset_y;
	   y = y1 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 4) begin
	   x = x1 - offset_x;
	   y = y1 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 3) begin
	   x = x1 - offset_y;
	   y = y1 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 5) begin
	   x = x1 - offset_x;
	   y = y1 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 6) begin
	   x = x1 - offset_y;
	   y = y1 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 7) begin
	   x = x1 + offset_x;
	   y = y1 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 8) begin
	   x = x1 + offset_y;
	   y = y1 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (y <= by2) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 9) begin
       offset_y = offset_y + 1;
	   temp = temp + 1;
	  end else begin  //2
	   if((crit[8] == 1'b1) ^ (crit == 0))begin //*
	    crit = crit + 2*offset_y + 1;
	   end //*
	   else begin //1
	    offset_x = offset_x - 1;
	    crit = crit + 2*(offset_y - offset_x) + 1;
	   end //1
	   temp = 1;
	  end //2
	  end //offset_y1 > offset_x1
	  else begin
	   i = i + 1;
	   offset_y = 1'b0;
	   offset_x = diameter;
	   crit = 1 - diameter;
	  end
	 end //the first cicle
	 
	 else if(i == 2) begin // the second circle
	   bx1 = x1;
	   by1 = y1;
	   bx2 = x3;
	   by2 = y3;
	   if(offset_y <= offset_x)begin //while offset_x <= offset_y
	  if(temp == 1) begin
	   x = x2 + offset_x;
	   y = y2 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 2) begin
	   x = x2 + offset_y;
	   y = y2 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 4) begin
	   x = x2 - offset_x;
	   y = y2 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 3) begin
	   x = x2 - offset_y;
	   y = y2 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 5) begin
	   x = x2 - offset_x;
	   y = y2 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 6) begin
	   x = x2 - offset_y;
	   y = y2 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 7) begin
	   x = x2 + offset_x;
	   y = y2 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 8) begin
	   x = x2 + offset_y;
	   y = y2 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y >= by1) && (x[8] != 1) && (y[7] != 1)&& (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 9) begin
       offset_y = offset_y + 1;
	   temp = temp + 1;
	  end else begin  //2
	   if((crit[8] == 1'b1) ^ (crit == 0))begin //*
	    crit = crit + 2*offset_y + 1;
	   end //*
	   else begin //1
	    offset_x = offset_x - 1;
	    crit = crit + 2*(offset_y - offset_x) + 1;
	   end //1
	   temp = 1;
	  end //2
	  end //offset_y1 > offset_x1
	  else begin
	   i = i + 1;
	   offset_y = 1'b0;
	   offset_x = diameter;
	   crit = 1 - diameter;
	  end
	 end //the second cicle
	 
	 else begin // the third circle
	   bx1 = x1;
	   by1 = y1;
	   bx2 = x2;
	   by2 = y2;
	   if(offset_y <= offset_x)begin
	  if(temp == 1) begin
	   x = x3 + offset_x;
	   y = y3 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 2) begin
	   x = x3 + offset_y;
	   y = y3 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 4) begin
	   x = x3 - offset_x;
	   y = y3 + offset_y;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 3) begin
	   x = x3 - offset_y;
	   y = y3 + offset_x;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 5) begin
	   x = x3 - offset_x;
	   y = y3 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 6) begin
	   x = x3 - offset_y;
	   y = y3 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 7) begin
	   x = x3 + offset_x;
	   y = y3 - offset_y;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 8) begin
	   x = x3 + offset_y;
	   y = y3 - offset_x;
	   if((x >= bx1) && (x <= bx2) && (y <= by1) && (y >= by2) && (x[8] != 1) && (y[7] != 1) && (x[7:0] < 160) && (y[6:0] < 120))begin
	    plot = 1'b1;
	   end 
	   else begin
	    plot = 1'b0;
	   end
	   temp = temp + 1;
	  end else if(temp == 9) begin
       offset_y = offset_y + 1;
	   temp = temp + 1;
	  end else begin  //2
	   if((crit[8] == 1'b1) ^ (crit == 0))begin //*
	    crit = crit + 2*offset_y + 1;
	   end //*
	   else begin //1
	    offset_x = offset_x - 1;
	    crit = crit + 2*(offset_y - offset_x) + 1;
	   end //1
	   temp = 1;
	  end //2
	  end //offset_y1 > offset_x1
	  else begin
	   done = 1'b1;
	   plot = 1'b0;
	  end
	 end //the third cicle
	 
	 end //4
	 else begin //3
	  plot = 1'b0;
	 end //3
	
	 end
	  
endmodule


module finishscreen(input logic clk, input logic rst_n, input logic [2:0] colour,
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


