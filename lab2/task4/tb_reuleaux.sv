module tb_reuleaux();

// Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.
    logic clk, rst_n, start;
	logic [2:0] colour, vga_colour;
	logic [7:0] centre_x;
	logic [7:0] diameter;
	logic [6:0] centre_y;
	logic done;
	logic vga_plot;
	logic [7:0] vga_x;
	logic [6:0] vga_y;
	logic signed[8:0] crit;
	logic [7:0] offset_x;
	logic [6:0] offset_y;
	
    reuleaux dut (.*);
    
	
    initial begin
	 clk = 1'b0; #5;
	  forever begin
	   clk = 1'b1; #5;
	   clk = 1'b0; #5;
	  end
	end
	
		initial begin
	 colour = 3'b010;
	 centre_x = 80;
	 centre_y = 60;
	 diameter = 80;
	 rst_n = 1'b0; #10;
	 rst_n = 1'b1;
	 start = 1'b1;
     #500000;
		 $stop;
	
	end

endmodule: tb_reuleaux

