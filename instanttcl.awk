#instant Throughput
#https://www.nsnam.com
BEGIN {
	recv=0
	currentTime = previousTime = 0
	timetic=1.0
}

{
event =$1
time=$2
node_id=$5
packet=$4
pkt_id=$6
flow_id=$39
packet_size=$8
#flow_type=$45

if(previousTime == 0)
	previousTime = time

if (packet == "AGT" && event == "r") {
	recv = recv + packet_size
	currentTime = currentTime + (time-previousTime)
	if (currentTime >= timetic) {
		printf ("%f %f \n", time,(recv/currentTime)*(8/1000))
		recv=0
		currentTime=0
	}
	previousTime=time
}
}
END {
printf("\n")
}

