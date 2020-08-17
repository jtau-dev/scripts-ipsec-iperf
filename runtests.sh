#!/usr/bin/bash

OPTS=`getopt -o s:n: --long nofl -n 'parse-options' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

NOFCH=1;
start=1;
NOF="";
while true; do
    case "$1" in
	-s ) start="$2";shift;shift;;
	-n ) NOFCH="$2";shift;shift;;
	--nofl ) NOF="--no-offload";shift;shift;;
	-- ) shift; break ;;
	* ) break ;;
    esac
done
echo $start

if [ ! -d data ]; then
    mkdir data
fi

NT=$start
for i in $( seq 1 $NOFCH ); do
    datacmd="unbuffer ./perfsum2.pl $NOF -s $start -n $i"
    echo $datacmd
    $datacmd  > data/${i}T.dat&
    jid=$!
    cmd="./iperf3_client.sh -s $start -n $i"
    echo $cmd
    $cmd
    kill $jid
    NT=$(( $NT + 1 ))
done
