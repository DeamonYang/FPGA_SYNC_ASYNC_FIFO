library verilog;
use verilog.vl_types.all;
entity async_fifo is
    port(
        rst_n           : in     vl_logic;
        fifo_wr_clk     : in     vl_logic;
        fifo_wr_en      : in     vl_logic;
        r_fifo_full     : out    vl_logic;
        fifo_wr_data    : in     vl_logic_vector(15 downto 0);
        fifo_rd_clk     : in     vl_logic;
        fifo_rd_en      : in     vl_logic;
        fifo_rd_data    : out    vl_logic_vector(15 downto 0);
        r_fifo_empty    : out    vl_logic
    );
end async_fifo;
