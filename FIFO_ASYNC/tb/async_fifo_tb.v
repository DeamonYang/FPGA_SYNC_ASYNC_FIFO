`timescale 1ns/1ns
module async_fifo_tb;


	reg rst_n			;
	reg fifo_wr_en	;
	reg[15:0]fifo_wr_data;

	reg fifo_rd_en	;
	reg fifo_rd_clk;
	reg fifo_wr_clk;

	wire r_fifo_full	;
	wire [15:0]fifo_rd_data;
	wire r_fifo_empty	;


	async_fifo async_fifo_u0(
		.rst_n			(rst_n			),
		.fifo_wr_clk	(fifo_wr_clk	),
		.fifo_wr_en	(fifo_wr_en	),
		.r_fifo_full	(r_fifo_full	),
		.fifo_wr_data(fifo_wr_data),
		.fifo_rd_clk	(fifo_rd_clk	),
		.fifo_rd_en	(fifo_rd_en	),
		.fifo_rd_data(fifo_rd_data),
		.r_fifo_empty	(r_fifo_empty	)
		
		);

	initial begin
		
		rst_n = 0;
		fifo_wr_en = 0;
		fifo_rd_en = 0;
		fifo_rd_clk = 0;
		fifo_wr_clk = 0;
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
	
	always #10 fifo_wr_clk = ~fifo_wr_clk;

	always #8	fifo_rd_clk = ~fifo_rd_clk;
	
	
	always @(posedge fifo_wr_clk or negedge rst_n)
	if(!rst_n)
		fifo_wr_data <= 16'd0;
	else if(fifo_wr_en && ~r_fifo_full)
		fifo_wr_data <= fifo_wr_data + 1'b1;

	always @(posedge fifo_rd_clk or negedge rst_n)
	if(!rst_n)
		fifo_rd_en <= 1'b0;
	else if(~r_fifo_empty)
		fifo_rd_en <= 1'b1;
	else 
		fifo_rd_en <= 1'b0;
		


endmodule
