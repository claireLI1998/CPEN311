module tb_circle();

// Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.
    logic clk, rst_n, start;
	logic [7:0]offset_x;
	logic [6:0]offset_y;
	logic [2:0] colour, vga_colour;
	logic [7:0] centre_x;
	logic [7:0] radius;
	logic [6:0] centre_y;
	logic done;
	logic vga_plot;
	logic [7:0] vga_x;
	logic [6:0] vga_y;   
	logic signed [8:0] crit;
   
	task pc;	 
	 
	 logic [8:0] x;
	 logic [7:0] y;
	 
	 while(offset_y <= offset_x) begin
	  x = centre_x + offset_x;
	  y = centre_y + offset_y;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x + offset_y;
	  y = centre_y + offset_x;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x - offset_y;
	  y = centre_y + offset_x;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x - offset_x;
	  y = centre_y + offset_y;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x - offset_x;
	  y = centre_y - offset_y;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x - offset_y;
	  y = centre_y - offset_x;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x + offset_x;
	  y = centre_y - offset_y;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  x = centre_x + offset_y;
	  y = centre_y - offset_x;
	  offset_y = offset_y + 1;
	  if(x > 159 || y > 119)begin
	   assert(vga_plot === 0);
	   #10;
	  end else begin
	  assert(vga_plot === 1);
	  assert(vga_x === x[7:0]);
	  assert(vga_y === y[6:0]);
	  assert(vga_colour === colour); 
	  #10;
	  end
	  
	  
	  assert(offset_y === dut.offset_y);
	  #10;
	  if(crit[8] === 1 || crit === 0)begin
	   crit = crit + 2*offset_y + 1;
	   assert(crit === dut.crit);
	   #10;
	  end
	  else begin
	   offset_x = offset_x - 1;
	   crit = crit + 2*(offset_y - offset_x) + 1;
	   assert(offset_x === dut.offset_x);
	   assert(offset_y === dut.offset_y);
	   #10;
	  end	  
	  
	end
	endtask
		
	circle dut (.*);	
	
    initial begin
	 clk = 1'b0; #5;
	  forever begin
	   clk = 1'b1; #5;
	   clk = 1'b0; #5;
	  end
	end
	
	initial begin
	
	//test 1
     colour = 3'b010;
	 centre_x = 80;
	 centre_y = 60;
	 radius = 40;
	 offset_x = radius;
	 offset_y = 0;
	 crit = 1- radius;
	 start = 1'b0;
	 rst_n = 1'b1; #5;
	 start = 1'b1;
	 rst_n = 1'b0; #5;
	 assert(dut.temp === 1);
	 rst_n = 1'b1; #10;
	 pc();
	 assert(done === 1'b1);
	 $display("Test1 passed");
	 #50;
	 
	 
	 //test 2
	 rst_n = 0;
     colour = 3'b010;
	 centre_x = 0;
	 centre_y = 0;
	 radius = 40;
	 offset_x = radius;
	 offset_y = 0;
	 crit = 1- radius;
	 start = 1'b0;
	 rst_n = 1'b1; #5;
	 start = 1'b1;
	 rst_n = 1'b0; #5;
	 assert(dut.temp === 1);
	 rst_n = 1'b1; #10;
	 pc();
	 assert(done === 1'b1);
	 $display("Test2 passed");
	 #50;
	 
	 //test 3
	 rst_n = 0;
     colour = 3'b010;
	 centre_x = 90;
	 centre_y = 100;
	 radius = 40;
	 offset_x = radius;
	 offset_y = 0;
	 crit = 1- radius;
	 start = 1'b0;
	 rst_n = 1'b1; #5;
	 start = 1'b1;
	 rst_n = 1'b0; #5;
	 assert(dut.temp === 1);
	 rst_n = 1'b1; #10;
	 pc();
	 assert(done === 1'b1);
	 $display("Test3 passed");
	 #50;
	 
    
	$stop;  
	 end
	
	
endmodule: tb_circle
