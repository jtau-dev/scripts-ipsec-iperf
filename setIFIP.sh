#!/usr/bin/bash

# network interface name
IFN=ens1f0
# Interface IP
IP=192.168.1.64

####
# Assume the 3rd byte is incremented.
# If this is changed, the script 'setupIPSecXport.sh' would have to be changed as well.
#
byte4=${IP##*.}
tmp=${IP%.*}
byte3=${tmp##*.}
bytes12=${tmp%.*}

CNT=2
ST1=$(( $byte3 + 1 ))
ST2=$(( $byte3 - 1 ))
ifconfig $IFN ${IP}/24

for bytei in $( seq $ST1 1 $(( $ST2 + ${1:-1})) )
do
    #cmd="ifconfig ${IFN}:$CNT $bytes12.$bytei.$byte4/24"
    cmd="ip addr add dev $IFN $bytes12.$bytei.$byte4/24"
    echo $cmd
    eval '$cmd'
    CNT=$(( $CNT + 1 ))
done
