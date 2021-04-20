#! /bin/tcsh -f

# Creating and mapping to logic name work the local work library

echo "Compile ensc450_system"
# <Compile here your own IP>
vcom -quiet ../vhdl/aes128key.vhd
vcom -quiet ../vhdl/aesbuffer.vhd
# -------------------------
vcom -quiet ../vhdl/tb_aes128.vhd

echo ""
echo ""

