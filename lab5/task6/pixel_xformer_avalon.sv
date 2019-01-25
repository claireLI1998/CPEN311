module pixel_xformer_avalon(input logic clk, input logic reset_n,
                            // slave
                            input logic [3:0] slave_address,
                            input logic slave_read, output logic [31:0] slave_readdata,
                            input logic slave_write, input logic [31:0] slave_writedata,
                            // master
                            input logic waitrequest, output logic [31:0] master_address,
                            output logic master_write, output logic [31:0] master_writedata);

    // your code here

endmodule: pixel_xformer_avalon