module tb_fillscreen();

// Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.
    logic clk, rst_n, start;
    logic [2:0] colour;  
    logic [7:0] x;
	logic [6:0] y;
    logic [7:0] vga_x;
    logic [6:0] vga_y;
    logic done, vga_plot;
    logic [2:0] vga_colour;
    

    fillscreen dut (.*);


    initial begin
        clk = 1'b0; #1;
        forever begin
        clk = 1'b1; #1;
        clk = 1'b0; #1;
        end
    end

    initial begin
	    rst_n = 1;
	    start = 0; #1;
		start = 1;
        rst_n = 0; #1;
		rst_n = 1;
		
		assert(vga_plot === 1'b0);
		assert(vga_x === 1'b0);
		assert(vga_y === 7'b1111111);
        #2;
		
		for(x = 0; x < 160; x ++) begin
		 for(y = 0; y < 120; y ++) begin
		  assert(vga_x === x);
		  assert(vga_y === y);
		  assert(vga_colour === x % 4'b1000);
		  assert(vga_plot === 1'b1);
		  #2;
		 end
		end
		
		assert(done === 1'b1);
		$display("Test passed");
		$stop;		
    end
    

endmodule: tb_fillscreen
