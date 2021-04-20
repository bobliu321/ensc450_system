set TIME_start [clock clicks -milliseconds]
source scripts/import.tcl
source scripts/03-buffer-powerPlan.tcl
source scripts/04-buffer-placement.tcl
source scripts/05-buffer-postPlaceOpt.tcl
source scripts/06-buffer-cts.tcl
source scripts/07-buffer-postCTSOpt.tcl
source scripts/08-buffer-route.tcl
source scripts/09-buffer-finishing.tcl
set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
set out "CPU run time: $TIME_taken ms"
puts stdout $out
