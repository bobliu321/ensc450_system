# Create Floorplan (45 nm)

# floorPlan -su <aspectRatio> [<stdCellDensity> [<coreToLeft> <coreToBottom> <coreToRight> <coreToTop>]]
set defOutLefDNR 1
set defOutLefVia 1
set lefDefOutVersion 5.5

exec rm -rf temp
exec mkdir temp
exec rm -rf results
exec mkdir results
exec mkdir results/summary
exec mkdir results/timing
exec mkdir results/verilog

floorPlan -su 1  0.70  4 4 4 4   
#floorplan -d 375 375 10 10 10 10
#setPlaceMode -fp true
#place_design
#addHaloToBlock {0.03 0.03 0.03 0.03} -fromInstBox -allMacro
#selectInst my_aes
#setObjFPlanBox Instance my_aes 18.505 120.565 188.655 288.285
#setObjFPlanBox Instance my_aes 18.505 157.1795 188.655 324.8995
#deselectAll
#selectInst my_Mem
#uiSetTool move
#setObjFPlanBox Instance my_Mem 212.7675 14.708 334.7675 136.708
#setObjFPlanBox Instance my_Mem 21.0735 20.0955 143.0735 143.0955
#setPlaceMode -fp true
#place_design





editPin -fixedPin 1 -snap TRACK -side Top -unit TRACK -layer 2 -spreadType center -spacing 5.0 \
        -pin {resetn clk {addr_in[0]} {addr_in[1]} {addr_in[2]} {addr_in[3]} {addr_in[4]} {addr_in[5]} {addr_in[6]} {addr_in[7]} {addr_in[8]} {addr_in[9]} {addr_in[10]} {addr_in[11]} {addr_in[12]} {addr_in[13]} {addr_in[14]} {addr_in[15]} {addr_in[16]} {addr_in[17]} {addr_in[18]} {addr_in[19]} {addr_in[20]} {addr_in[21]} {addr_in[22]} {addr_in[23]} {addr_in[24]} {addr_in[25]} {addr_in[26]} {addr_in[27]} {addr_in[28]} {addr_in[29]} {addr_in[30]} {addr_in[31]} mr mw {data_in[0]} {data_in[1]} {data_in[2]} {data_in[3]} {data_in[4]} {data_in[5]} {data_in[6]} {data_in[7]} {data_in[8]} {data_in[9]} {data_in[10]} {data_in[11]} {data_in[12]} {data_in[13]} {data_in[14]} {data_in[15]} {data_in[16]} {data_in[17]} {data_in[18]} {data_in[19]} {data_in[20]} {data_in[21]} {data_in[22]} {data_in[23]} {data_in[24]} {data_in[25]} {data_in[26]} {data_in[27]} {data_in[28]} {data_in[29]} {data_in[30]} {data_in[31]} }
#-use TIELOW is meant to set output pinst to 0. Notice how these pins are all of type output.
editPin -fixedPin 1 -snap TRACK -side Right -use TIELOW -unit TRACK -layer 2 -spreadType center -spacing 10.0 \
        -pin {{data_out[0]} {data_out[1]} {data_out[2]} {data_out[3]} {data_out[4]} {data_out[5]} {data_out[6]} {data_out[7]} {data_out[8]} {data_out[9]} {data_out[10]} {data_out[11]} {data_out[12]} {data_out[13]} {data_out[14]} {data_out[15]} {data_out[16]} {data_out[17]} {data_out[18]} {data_out[19]} {data_out[20]} {data_out[21]} {data_out[22]} {data_out[23]} {data_out[24]} {data_out[25]} {data_out[26]} {data_out[27]} {data_out[28]} {data_out[29]} {data_out[30]} {data_out[31]}}

# Building a Power Ring for Vdd / Vdds, extending top/bottom segments to create pins
# From the LEF file we know that M9 and M10 are the highest metals, and that the min width of the M9 M10 metals
# is 0.8. We need to make this ring a multiple of 0.8.Since the area is small, we dont expect huge consumption,
# we keep it at pitch. 
# Note that in the foorplan we must reserve enough space between core (rows) and pins to build rings 

addRing -nets {VDD VSS} -width 0.6 -spacing 0.5 \
       -layer [list top 7 bottom 7 left 6 right 6]

#hookup the rings with stripes
addStripe -nets {VSS VDD} -layer 6 -direction vertical -width 0.4 -spacing 0.5 -set_to_set_distance 5
addStripe -nets {VSS VDD} -layer 7 -direction horizontal -width 0.4 -spacing 0.5 -set_to_set_distance 5
#globalNetConnect VDD -type pgpin -pin VDD -autoTie
#globalNetConnect VSS -type pgpin -pin VSS -autoTie
#globalNetConnect VDD -type pgpin -pin VDD -inst * -all -override
#globalNetConnect VSS -type pgpin -pin VSS -inst * -all -override
#clearGlobalNets
#globalNetConnect VDD -type pgpin -pin VDD -instanceBasename *
#globalNetConnect VDD -type tiehi -instanceBasename *
#globalNetConnect VSS -type pgpin -pin VSS -instanceBasename *
#globalNetConnect VSS -type tielo -instanceBasename *
#globalNetConnect VDD -type pgpin -pin dbgTieHighNet -instanceBasename *
#globalNetConnect VSS -type pgpin -pin dbgTieLowNet -instanceBasename *

#globalNetConnect VDD -type pgpin -pin VDD -all
#globalNetConnect VSS -type pgpin -pin VSS -all
#globalNetConnect -disconnect -pin VDD -type pgpin -singleInstance my_Mem
#globalNetConnect VDD -pin VDD -type pgpin -singleInstance my_Mem
#globalNetConnect -disconnect -pin VSS -type pgpin -singleInstance my_Mem
#globalNetConnect VSS -pin VSS -type pgpin -singleInstance my_Mem

#globalNetConnect -disconnect -pin VDD -type pgpin -singleInstance my_aes
#globalNetConnect VDD_BLOCK -pin VDD -type pgpin -singleInstance my_aes
#globalNetConnect -disconnect -pin VSS -type pgpin -singleInstance my_aes
#globalNetConnect VSS_BLOCK -pin VSS -type pgpin -singleInstance my_aes

sroute -connect { blockPin corePin floatingStripe } -routingEffort allowShortJogs  -nets {VDD VSS}

defOut -floorplan -noStdCells results/aesbuffer_floor.def
saveDesign ./DBS/03-floorplan.enc -relativePath -compress
summaryReport -outfile results/summary/03-floorplan.rpt

