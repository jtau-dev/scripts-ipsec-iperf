# scripts-ipsec-iperf
Scripts to use to help run multiple iperf3 client/server tunnels.
Run mkfifos to generate named fifos to redirect the outputs of the iperf3s
Run setIFIP.sh to assign multiple IPs to same I/F.
Run iperf3b_server.sh on server side.
Run iperf3_client.sh on client side.
Assume IPs in different subnets in the form of x.x.N.a and x.x.N.a+1 on the two ends.
Run perfsum2.pl to collect outputs and compute simple statistics.

Use runtests.sh to auto sweep number of tunnels and collect data.

NOTE: 
