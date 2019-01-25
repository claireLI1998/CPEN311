module prga(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            input logic [23:0] key,
            output logic [7:0] s_addr, input logic [7:0] s_rddata, output logic [7:0] s_wrdata, output logic s_wren,
            output logic [7:0] ct_addr, input logic [7:0] ct_rddata,
            output logic [7:0] pt_addr, input logic [7:0] pt_rddata, output logic [7:0] pt_wrdata, output logic pt_wren);

    // your code here
	logic protocol;
	logic [7:0] i, j, k;
	logic [4:0] count;
	logic [2:0] temp;
	logic done, start;
	logic [7:0] si, sj, iaddr, jaddr, sumaddr, ml, cipher, pad;
	
  
always @(posedge clk or negedge rst_n) begin
	
	if(rst_n == 1'b0) begin//1
	 i = 0;
	 j = 0;
	 k = 1;
	 count = 0;
	 s_wren = 0;
	 pt_wren = 0;
	 temp = 0;
	 rdy = 1;
	 protocol = 0;
	end //1
	
	else begin //2
	   if(count == 0) begin
	    if(en == 1 && protocol == 0) begin
		 rdy = 0;
		 count = 18;
		end else begin
		 i = 0;
	     j = 0;
	     k = 0;
	     s_wren = 0;
	     pt_wren = 0;
	     temp = 0;
	     rdy = 1;
	     protocol = 0;
		end
	end 
	else if(count == 1) begin
	    ct_addr = k;
		temp = temp + 1;
		count = count + 1;
	   end 		
	   else if(count == 2) begin
	    temp = temp + 1;
		count = count + 1;
	   end
	   else if(count == 3) begin
	    temp = temp + 1;
		count = count + 1;
	   end 
	   else if(count == 4) begin
	    ml = ct_rddata; //get the message length
		pt_wren = 1;
		pt_addr = 0;
		pt_wrdata = ml;
		k = k +1;
		temp = 4;
		count = count + 1;
	   end
	   else if(count == 5) begin
	    if(k <= (ml)) begin
		 i = (i + 1) % 256; 
		 s_addr = i;
		 iaddr = i;
		 count = count + 1;
		end else begin
		 rdy = 1;
		 s_wren = 0;
		 pt_wren = 0;
		 start = 0;
		 count = 17;
		end
	   end
	   else if(count == 6) begin
		count = count + 1;
	   end	  
	   else if(count == 7) begin
	    count = count + 1;
	   end 
	   else if(count == 8) begin
	    si = s_rddata;
		j = (j + si) % 256;
		s_addr = j;
		jaddr = j;
	    count = count + 1;
	   end 
	   else if(count == 9) begin
	    count = count + 1;
	   end
	   else if(count == 10) begin
	    count = count + 1;
	   end 
	   else if(count == 11) begin
	    sj = s_rddata;
		sumaddr = (si + sj) % 256;
		s_wrdata = sj;
		s_addr = iaddr;
	    s_wren = 1;
	    count = count + 1;
	   end 
	   else if(count == 12) begin
	    s_wrdata = si;
		s_addr = jaddr;
	    s_wren = 1;
	    count = count + 1;
	   end 
	   else if(count == 13) begin
	    s_addr = sumaddr;
		ct_addr = k;
		s_wren = 0;
		pt_wren = 0;
	    count = count + 1;
	   end
	   else if(count == 14) begin
	    count = count + 1;
	   end 
	   else if(count == 15) begin
	    count = count + 1;
	   end 
	   else if(count == 16) begin
	    pad = s_rddata;
		cipher = ct_rddata;
		pt_wrdata = pad ^ cipher;
		pt_wren = 1;
		pt_addr = k;
		k = k + 1;
	    count = 5;
	   end
	   else if(count == 17)begin 
	    rdy = 1;
		s_wren = 0;
		pt_wren = 0;
		start = 0;
		count = 17;
	   end	
       else begin
        count = 1;
       end
	   
	end //2

end //end block
	  
	
	
endmodule: prga