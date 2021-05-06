#nodes- 20,4,0,50,60,80,100
set terminal pdf
set output "THROUGHPUT.pdf"
set title "Throughput vs Nodes"
set xlabel "Number of Nodes"
set ylabel "Throughput"
plot "all_graphs.dat" using 1:2 with linespoints title "DSDVT","all_graphs.dat" using 1:3 with linespoints title "DSDVU"

set terminal pdf
set output "PDF.pdf"
set title "PDF vs Nodes"
set xlabel "Number of Nodes"
set ylabel "Packet Delivery Ratio"
plot "all_graphs.dat" using 1:4 with linespoints title "DSDVT","all_graphs.dat" using 1:5 with linespoints title "DSDVU"

set terminal pdf
set output "N_2_N.pdf"
set title "Average End-TO-End Delay vs nodes"
set xlabel "Number of Nodes"
set ylabel "Delay in millisec(ms)"
plot "all_graphs.dat" using 1:10 with linespoints title "DSDVT","all_graphs.dat" using 1:11 with linespoints title "DSDVU"

set terminal pdf
set output "AVG_RES_ENE.pdf"
set title "Average Residual Energy vs Nodes"
set xlabel "Number of Nodes"
set ylabel "Residual Energy in joules"
plot "all_graphs.dat" using 1:8 with linespoints title "DSDVT","all_graphs.dat" using 1:9 with linespoints title "DSDVU"

set terminal pdf
set output "RES_ENE.pdf"
set title "Total Residual Energy vs Nodes"
set xlabel "Number of Nodes"
set ylabel "Residual Energy in joules"
plot "all_graphs.dat" using 1:6 with linespoints title "DSDVT","all_graphs.dat" using 1:7 with linespoints title "DSDVU"




