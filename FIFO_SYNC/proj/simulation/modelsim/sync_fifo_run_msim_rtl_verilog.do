transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/rtl {L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/rtl/sync_fifo.v}
vlog -vlog01compat -work work +incdir+L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/ip {L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/ip/ram.v}

vlog -vlog01compat -work work +incdir+L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/proj/../tb {L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/proj/../tb/sync_fifo_tb.v}
vlog -vlog01compat -work work +incdir+L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/proj/../rtl {L:/FPWG_WORK/FPGA_FIFO/FIFO_SYNC/proj/../rtl/sync_fifo.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sync_fifo_tb

add wave *
view structure
view signals
run -all
