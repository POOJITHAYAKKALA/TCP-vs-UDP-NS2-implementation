set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             50                         ;# number of mobilenodes
set val(rp)             DSDV                       ;# routing protocol
# set floor size
set opt(x) 2824
set opt(y) 2053

# Energy Parameters
# ==============================================================================

set val(energymodel_11)         EnergyModel		;
set val(initialenergy_11)       1000            ;# Initial energy in Joules

set val(idlepower_11)			869.4e-3		;#LEAP (802.11g)
set val(rxpower_11)				1560.6e-3		;#LEAP (802.11g)
set val(txpower_11)				1679.4e-3		;#LEAP (802.11g)
set val(sleeppower_11)			37.8e-3			;#LEAP (802.11g)
set val(transitionpower_11)		176.695e-3		;#LEAP (802.11g)
set val(transitiontime_11)		2.36			;#LEAP (802.11g)


# ======================================================================
# Main Program
# ======================================================================


#
# Initialize Global Variables
#
set ns_		[new Simulator]
set tracefd     [open Dsdvt.tr w]
$ns_ trace-all $tracefd

set namf [open Dsdvt.nam w]
$ns_ namtrace-all-wireless $namf $opt(x) $opt(y)

$ns_ use-newtrace
# set up topography object
set topo       [new Topography]

$topo load_flatgrid $opt(x) $opt(y)

#
# Create God
#
create-god $val(nn)

#
#  Create the specified number of mobilenodes [$val(nn)] and "attach" them
#  to the channel. 
#  Here two nodes are created : node(0) and node(1)

# configure node

        $ns_ node-config -adhocRouting $val(rp) \
			 -llType $val(ll) \
			 -macType $val(mac) \
			 -ifqType $val(ifq) \
			 -ifqLen $val(ifqlen) \
			 -antType $val(ant) \
			 -propType $val(prop) \
			 -phyType $val(netif) \
			 -channelType $val(chan) \
			 -energyModel $val(energymodel_11) \
			        -idlePower $val(idlepower_11) \
			        -rxPower $val(rxpower_11) \
			        -txPower $val(txpower_11) \
          		    -sleepPower $val(sleeppower_11) \
          		    -transitionPower $val(transitionpower_11) \
			        -transitionTime $val(transitiontime_11) \
			        -initialEnergy $val(initialenergy_11) \
			 -topoInstance $topo \
			 -agentTrace ON \
			 -routerTrace ON \
			 -macTrace OFF \
			 -movementTrace ON			
			 
	for {set i 0} {$i < $val(nn) } {incr i} {
		set node_($i) [$ns_ node]	
		$node_($i) random-motion 0		;# disable random motion
		$ns_ initial_node_pos $node_($i) 20
	}




source mobility.tcl
set tcp [new Agent/TCP]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp
$ns_ attach-agent $node_(38) $sink
$ns_ connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns_ at 10.0 "$ftp start" 

#
# Tell nodes when the simulation ends
#
for {set i 0} {$i < $val(nn) } {incr i} {
    $ns_ at 100.0 "$node_($i) reset";
}
$ns_ at 100.0 "stop"
$ns_ at 100.01 "puts \"NS EXITING...\" ; $ns_ halt"
proc stop {} {
    global ns_ tracefd
    $ns_ flush-trace
    close $tracefd
}

puts "Starting Simulation..."
$ns_ run

