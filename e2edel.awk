# ===================================================================

# AWK Script for calculating: 

#     => Average End-to-End Delay.

# ===================================================================
BEGIN {
    seqno = -1;    
    count = 0;
    stime = 0;
    dtime = 0;
}

{
    if($1 == "s") {
          stime = stime+$3;
    }
    if($1 == "r") {
          dtime = dtime+$3;
          count++;
    }
 

    #end-to-end delay
}
END {          
         
    
	
   n_to_n_delay = (dtime-stime)/count;

    print "\n";
    print "Average End-to-End Delay    = " n_to_n_delay * 1000 " ms";
    print "\n";

}
