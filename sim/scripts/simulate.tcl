vsim E 
add wave -radix hex {/e/clk} {/e/resetn} {/e/EXT_MR} {/e/EXT_MW} {/e/EXT_ADDRBUS} {/e/EXT_RDATABUS} {/e/EXT_WDATABUS} 
restart -f ; run 7000 ns
