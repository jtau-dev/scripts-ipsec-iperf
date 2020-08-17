#!/usr/bin/bash


FIFO_DIR="/root/ipsec/fifos/"

if [ ! -d $FIFO_DIR ]; then
    mkdir -p $FIFO_DIR
fi

for i in $( seq 1 ${1:-1} ); do
 if [ ! -p "${FIFO_DIR}fifo${i}" ]; then
    cmd="mknod ${FIFO_DIR}fifo${i} p"
    echo $cmd
    $cmd
 fi
done

