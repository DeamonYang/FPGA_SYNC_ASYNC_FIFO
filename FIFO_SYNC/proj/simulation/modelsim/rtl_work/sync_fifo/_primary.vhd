library verilog;
use verilog.vl_types.all;
entity sync_fifo is
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        fifo_wr_en      : in     vl_logic;
        fifo_full       : out    vl_logic;
        fifo_wr_data    : in     vl_logic_vector(15 downto 0);
        fifo_rd_en      : in     vl_logic;
        fifo_rd_data    : out    vl_logic_vector(15 downto 0);
        fifo_empty      : out    vl_logic;
        fifo_wr_err     : out    vl_logic;
        fifo_rd_err     : out    vl_logic
    );
end sync_fifo;
