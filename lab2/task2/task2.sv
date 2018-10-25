module task2(input logic CLOCK_50, input logic [3:0] KEY, // KEY[3] is async active-low reset
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
    logic done;
    logic [2:0] colour;
	
    assign VGA_R = VGA_R_10[9:2];
    assign VGA_G = VGA_G_10[9:2];
    assign VGA_B = VGA_B_10[9:2];
    

    fillscreen fill ( .clk(CLOCK_50), 
                      .rst_n(KEY[3]),    // active low asynch reset
                      .colour(colour),
                      .start(start),
                      .done(done),
                      .vga_x(vga_x),
                      .vga_y(vga_y),
                      .vga_colour(vga_colour),
                      .vga_plot(vga_plot)
                       );

    vga_adapter #(.RESOLUTION("160x120")) vga_u0(.resetn(KEY[3]), .clock(CLOCK_50), .colour(vga_colour),
                                                .x(vga_x), .y(vga_y), .plot(vga_plot), .VGA_R(VGA_R_10), .VGA_G(VGA_G_10), .VGA_B(VGA_B_10), .*);
												
	always_ff @(posedge CLOCK_50 or negedge KEY[3]) begin
	 if(KEY[3] == 1'b0) begin  
	  start = 1'b0;
     end 
	 else if (done == 1'b0) begin  
	  start = 1'b1;
	 end 
	 else begin
	  start = 1'b0;  
	 end 
    end	 
endmodule: task2

