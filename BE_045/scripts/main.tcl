set TIME_start [clock clicks -milliseconds]
source scripts/import_ensc450.tcl
source scripts/03-powerPlan.tcl
source scripts/04-placement.tcl
source scripts/05-postPlaceOpt.tcl
source scripts/06-cts.tcl
source scripts/07-postCTSOpt.tcl
source scripts/08-route.tcl
source scripts/09-finishing.tcl
set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
set out "CPU run time: $TIME_taken ms"
puts stdout $out
