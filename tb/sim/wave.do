onerror {resume}
quietly WaveActivateNextPane {} 0

# Clock
add wave -noupdate -expand -group CLOCK /testbench/clk

# APB Interface Signals
add wave -noupdate -expand -group APB /testbench/apb_if/pclk
add wave -noupdate -expand -group APB /testbench/apb_if/preset_n
add wave -noupdate -expand -group APB /testbench/apb_if/paddr
add wave -noupdate -expand -group APB /testbench/apb_if/pwdata
add wave -noupdate -expand -group APB /testbench/apb_if/pwrite
add wave -noupdate -expand -group APB /testbench/apb_if/psel
add wave -noupdate -expand -group APB /testbench/apb_if/penable
add wave -noupdate -expand -group APB /testbench/apb_if/pready
add wave -noupdate -expand -group APB /testbench/apb_if/prdata
add wave -noupdate -expand -group APB /testbench/apb_if/pslverr

# MD_RX Interface Signals
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/clk
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/reset_n
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/valid
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/data
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/offset
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/size
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/ready
add wave -noupdate -expand -group MD_RX /testbench/md_rx_if/err

# MD_TX Interface Signals
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/clk
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/reset_n
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/valid
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/data
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/offset
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/size
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/ready
add wave -noupdate -expand -group MD_TX /testbench/md_tx_if/err

# DUT Ports (Top-level I/O seen from testbench)
add wave -noupdate -expand -group DUT /testbench/dut/clk
add wave -noupdate -expand -group DUT /testbench/dut/reset_n
add wave -noupdate -expand -group DUT /testbench/dut/paddr
add wave -noupdate -expand -group DUT /testbench/dut/pwrite
add wave -noupdate -expand -group DUT /testbench/dut/psel
add wave -noupdate -expand -group DUT /testbench/dut/penable
add wave -noupdate -expand -group DUT /testbench/dut/pwdata
add wave -noupdate -expand -group DUT /testbench/dut/pready
add wave -noupdate -expand -group DUT /testbench/dut/prdata
add wave -noupdate -expand -group DUT /testbench/dut/pslverr

add wave -noupdate -expand -group DUT /testbench/dut/md_rx_valid
add wave -noupdate -expand -group DUT /testbench/dut/md_rx_data
add wave -noupdate -expand -group DUT /testbench/dut/md_rx_offset
add wave -noupdate -expand -group DUT /testbench/dut/md_rx_size
add wave -noupdate -expand -group DUT /testbench/dut/md_rx_ready
add wave -noupdate -expand -group DUT /testbench/dut/md_rx_err

add wave -noupdate -expand -group DUT /testbench/dut/md_tx_valid
add wave -noupdate -expand -group DUT /testbench/dut/md_tx_data
add wave -noupdate -expand -group DUT /testbench/dut/md_tx_offset
add wave -noupdate -expand -group DUT /testbench/dut/md_tx_size
add wave -noupdate -expand -group DUT /testbench/dut/md_tx_ready
add wave -noupdate -expand -group DUT /testbench/dut/md_tx_err

TreeUpdate [SetDefaultTree]
update
run -all
