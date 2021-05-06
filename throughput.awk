BEGIN{
stime=0
ftime=0
flag=0
fsize=0
thro=0.0
lat=0.0
}
{
if($1=="r" && $5==19)
{
fsize+=$37
if(flag=0)
{
stime=$3
flag=1
}
ftime=$3
}
}
END{
lat=ftime-stime
thro=(fsize*8)/lat
printf("starttime : %f",stime)
printf("\n end time : %f",ftime)
printf("\n latency : %f",lat)
printf("\n throughput : %f",thro)
}
