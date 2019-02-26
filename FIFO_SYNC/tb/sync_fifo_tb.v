module sync_fifo_tb;

		reg rst_n			;
		reg clk			;
		reg fifo_wr_en	;
		reg [15:0]fifo_wr_data;
		reg fifo_rd_en	;
		
		wire fifo_full	;
		wire [15:0]fifo_rd_data;
		wire fifo_empty	;
		wire fifo_wr_err;
		wire fifo_rd_err;

sync_fifo sync_fifo_u1(
		.rst_n		(rst_n			),
		.clk			(clk			),
		.fifo_wr_en	(fifo_wr_en	),
		.fifo_full	(fifo_full	),
		.fifo_wr_data(fifo_wr_data),
		.fifo_rd_en	(fifo_rd_en	),
		.fifo_rd_data(fifo_rd_data),
		.fifo_empty	(fifo_empty	),
		.fifo_wr_err	(fifo_wr_err	),
		.fifo_rd_err	(fifo_rd_err	)
		
	);

	always #10 clk = ~clk;
	
	initial begin
		rst_n = 0;
		clk = 0;
		fifo_wr_en = 0;
		#1000;
		rst_n = 1;
		#200;
		fifo_wr_en = 1;
		#4000;
		fifo_wr_en = 0;
	

		#2000;
		fifo_wr_en = 1;
		#4000;
		fifo_wr_en = 0;	
		
		#4000;
		$stop;
	end
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		fifo_wr_data <= 16'd0;
	else if(fifo_wr_en && ~fifo_full)
		fifo_wr_data <= fifo_wr_data + 1'b1;

	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		fifo_rd_en <= 1'b0;
	else if(~fifo_empty)
		fifo_rd_en <= 1'b1;
	else 
		fifo_rd_en <= 1'b0;
	
	
	

endmodule

