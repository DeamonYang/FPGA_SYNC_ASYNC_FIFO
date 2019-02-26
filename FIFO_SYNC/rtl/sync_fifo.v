module sync_fifo(
		rst_n			,
		clk			,
		fifo_wr_en	,
		fifo_full	,
		fifo_wr_data,
		
		fifo_rd_en	,
		fifo_rd_data,
		fifo_empty	,
		
		fifo_wr_err,
		fifo_rd_err
		
	);

		input rst_n			;
		input clk			;
		input fifo_wr_en	;
		input	[15:0]fifo_wr_data;
		input fifo_rd_en	;
		
		output fifo_full	;
		output [15:0]fifo_rd_data;
		output fifo_empty	;
		
		
		output fifo_wr_err;
		output fifo_rd_err;
		
		reg	[8:0]  rdaddress;
		reg	[8:0]  wraddress;
	
		reg	[9:0]data_cnt;
		
		assign fifo_full = (data_cnt == 10'h200);
		assign fifo_empty = (data_cnt == 10'd0);
		
		assign fifo_wr_err = (data_cnt == 10'h200 && fifo_wr_en);
		assign fifo_rd_err = (data_cnt == 10'd00 && fifo_rd_en);
	
		ram  ram(
			.clock		(clk),
			.data			(fifo_wr_data),
			.rdaddress	(rdaddress),
			.wraddress	(wraddress),
			.wren			(fifo_wr_en),
			.q				(fifo_rd_data)
			);
			
		
			
		/*读数据地址生成*/
		always@(posedge clk or negedge rst_n)
		if(!rst_n)
			rdaddress <= 9'b0;
		else if(fifo_rd_en && ~fifo_empty)begin
			rdaddress <= rdaddress + 1'b1;
		end
		
		/*写数据地址生成*/
		always@(posedge clk or negedge rst_n)
		if(!rst_n)
			wraddress <= 9'b0;
		else if(fifo_wr_en && ~fifo_full)begin
			wraddress <= wraddress + 1'b1;
		end
		
		/*fifo 中存储的数据长度计数*/
		always@(posedge clk or negedge rst_n)
		if(!rst_n)
			data_cnt <= 10'b0;
		else if(fifo_wr_en && ~fifo_rd_en && ~fifo_full)
			data_cnt <= data_cnt + 1'b1;
		else if(fifo_rd_en && ~fifo_wr_en && ~fifo_empty)
			data_cnt <= data_cnt - 1'b1;
		else 
			data_cnt <= data_cnt;

endmodule
