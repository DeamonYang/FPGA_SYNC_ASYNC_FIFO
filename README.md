# FPGA_SYNC_ASYNC_FIFO
FPGA 同步FIFO与异步FIFO

在异步fifo 中使用格雷码编码读写地址，
通过两级寄存器跨时钟域将写地址同步到读时钟域，将读地址同步到写时钟域
参考文献 Simulation and Synthesis Techniques for Asynchronous FIFO Design
为此异步FIFO的理论依据

