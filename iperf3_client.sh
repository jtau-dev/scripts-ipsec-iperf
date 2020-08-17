#!/usr/bin/bash
#
FIFO_DIR=/root/ipsec/fifos/
RUNTIME=60
#

OPTS=`getopt -o s:n: -n 'parse-options' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

NOFCH=1;
start=1;
while true; do
    case "$1" in
	-s ) start="$2";shift;shift;;
	-n ) NOFCH="$2";shift;shift;;
	-- ) shift; break ;;
	* ) break ;;
    esac
done

IFN=ens1f0
CNT=1
IPA=`ip addr show $IFN | grep -E "inet.*global ${IFN}$" | awk '{print $2}'`
for i in $IPA
do
   if [[ $CNT -ge $start ]] && [[ $CNT -le $NOFCH ]]; then
    IP=${i%\/*}
    byte4=${IP##*.}
    bytes123=${IP%.*}
    IP=$bytes123.$(( $byte4 + 1 ))
    #iperf3 -s -B $IPA &
    core=$(( 7+$CNT ))
    cmd="taskset -c $core iperf3 -c $IP -P1 --logfile /root/ipsec/fifos/fifo${CNT} -t 300"
    echo $cmd
    $cmd&
   fi
   CNT=$(( $CNT + 1 ))
done
wait 
