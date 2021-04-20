# Simple script for compiling a vhdl file for simulation
# fcampi@sfu.ca

# Cleaning the work folder (This should not be done if compiling incrementally)
\rm -rf work

# Creating and mapping to logic name work the local work library
vlib work
vmap work work

# Compiling the VHDL code for simulation
vlog -quiet /CMC/setups/ensc450/SOCLAB/LIBRARIES/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog/NangateOpenCellLibrary.v
vlog ../sim/finalv/ensc450.final.v 
vlog ../sim/finalv/aesbuffer.final.v 
vcom -quiet ../vhdl/SRAM_Lib/SRAM.vhd
#vcom ../vhdl/tb_ensc450_1.vhd 
vcom ../vhdl/tb_ensc450_2.vhd 
#vcom ../vhdl/tb_ensc450_3.vhd 

