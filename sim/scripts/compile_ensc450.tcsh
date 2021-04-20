#! /bin/tcsh -f

# Creating and mapping to logic name work the local work library

echo "Compile ensc450_system"
# <Compile here your own IP>
vcom -quiet ../vhdl/aes128key.vhd
vcom -quiet ../vhdl/aesbuffer.vhd
# -------------------------
vcom -quiet ../vhdl/SRAM_Lib/SRAM.vhd
vcom -quiet ../vhdl/ubus.vhd
vcom -quiet ../vhdl/dma.vhd
vcom -quiet ../vhdl/counter.vhd
vcom -quiet ../vhdl/ensc450.vhd
#vcom -quiet ../vhdl/tb_ensc450_1.vhd
vcom -quiet ../vhdl/tb_ensc450_2.vhd
#vcom -quiet ../vhdl/tb_ensc450_3.vhd

echo ""
echo ""

