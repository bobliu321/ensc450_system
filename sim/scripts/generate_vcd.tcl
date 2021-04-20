vsim E
restart -f
# Run Init time (Time needed to put the system in a consistent state, but that you don't want to measure. For example reset time, operand read, etc)
run 20 ns
#vcd add -file aesbuffer.vcd -r /e/uut/* 
vcd add -file ensc450.vcd -r /e/uut/* 
# Run VCD time, depending on how long is the period you want to run your power analysis upon
run 4000ns
# Closes vcd file
#vcd flush aesbuffer.vcd
vcd flush ensc450.vcd
#vcd2saif -input aesbuffer.vcd -output aesbuffer.vcd.saif 
vcd2saif -input ensc450.vcd -output ensc450.vcd.saif 
