module task3(input logic CLOCK_50, input logic [3:0] KEY, // KEY[3] is async active-low reset
             input logic [9:0] SW, output logic [9:0] LEDR,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [7:0] VGA_R, output logic [7:0] VGA_G, output logic [7:0] VGA_B,
             output logic VGA_HS, output logic VGA_VS, output logic VGA_CLK);

    // instantiate and connect the VGA adapter and your module
    wire [2:0] vga_colour;
    wire [7:0] vga_x;
    wire [6:0] vga_y;
    wire vga_plot;
	logic [9:0] VGA_R_10;
    logic [9:0] VGA_G_10;
    logic [9:0] VGA_B_10;
    logic VGA_BLANK, VGA_SYNC;
	logic start;
	logic cstart;
    logic done;
	logic cdone;
	logic [2:0] clear;
    logic [2:0] colour, vga_colour1, vga_colour2;
	logic [7:0] centre_x;
	logic [6:0] centre_y;
	logic [7:0] radius;
	logic initvga_x, initvga_y, initvga_plot, initvga_colour;
	logic [7:0] vga_x1, vga_x2;
	logic [6:0] vga_y1, vga_y2;
	logic vga_plot1, vga_plot2;
	
	assign colour = 3'b010;
	assign clear = 3'b000;
	assign radius = 40;
	assign centre_x = 80;
	assign centre_y = 60;
	
	assign VGA_R = VGA_R_10[9:2];
    assign VGA_G = VGA_G_10[9:2];
    assign VGA_B = VGA_B_10[9:2];

	assign vga_x = initvga_x ? vga_x1 : vga_x2;
	assign vga_y = initvga_y ? vga_y1 : vga_y2;
	assign vga_plot = initvga_plot ? vga_plot1 : vga_plot2;
	assign vga_colour = initvga_colour ? vga_colour1 : vga_colour2;
	
	circle c(.clk(CLOCK_50), .rst_n(KEY[3]), .colour(colour),
              .centre_x(centre_x), .centre_y(centre_y), .radius(radius),
              .start(start), .done(done),
              .vga_x(vga_x1), .vga_y(vga_y1),
              .vga_colour(vga_colour1), .vga_plot(vga_plot1));
	
	clearscreen cs(.clk(CLOCK_50), .rst_n(KEY[3]), .colour(clear),
                  .start(cstart), .done(cdone),
                  .vga_x(vga_x2), .vga_y(vga_y2),
                  .vga_colour(vga_colour2), .vga_plot(vga_plot2));
				  
	vga_adapter #(.RESOLUTION("160x120")) vga_u0(.resetn(KEY[3]), .clock(CLOCK_50), .colour(vga_colour),
                                                .x(vga_x), .y(vga_y), .plot(vga_plot), .VGA_R(VGA_R_10), .VGA_G(VGA_G_10), .VGA_B(VGA_B_10), .*);
	
		
	always_ff @(posedge CLOCK_50) begin
	 if(KEY[3] == 1'b0) begin
	  cstart = 1'b1;
	  start = 1'b0;
	  initvga_colour = 0;
	  initvga_plot = 0;
	  initvga_y = 0;
	  initvga_x = 0;
     end 
	 else if (cdone == 1'b1) begin
	  cstart = 1'b0;
	  start = 1'b1;
	  initvga_colour = 1;
	  initvga_plot = 1;
	  initvga_y = 1;
	  initvga_x = 1;
	 end 
	 else if (done == 1'b1) begin
	  start = 1'b0;
	  initvga_colour = 1;
	  initvga_plot = 1;
	  initvga_y = 1;
	  initvga_x = 1;
	 end 
	end

endmodule: task3
