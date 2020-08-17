#!/usr/bin/bash

IFN=enp97s0f0
IP=`ip addr show $IFN | grep -E "inet.*global ${IFN}$" | awk '{print $2}'`
core=24
for i in $IP
do
    IPA=${i%\/*}
    taskset -c $core iperf3 -s -B $IPA &
    core=$(( $core + 1 ))
done

#wait
