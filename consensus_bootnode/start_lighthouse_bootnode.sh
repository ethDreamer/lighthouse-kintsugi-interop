#!/bin/bash

BOOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $BOOT_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $DATADIR ]; then
	echo "Error: must run setup_datadir.sh before running this"
	exit 1
fi

if [ ! -e $LIGHTHOUSE_BINARY ]; then
	echo "Error: file '$LIGHTHOUSE_BINARY' not found."
	echo "Ensure \$LIGHTHOUSE_BINARY is set correctly in config.env"
	exit 1
fi

cleanup() {
	rm -rf $DATADIR/lighthouse/beacon/network
}
trap 'cleanup' SIGINT SIGTERM EXIT

$LIGHTHOUSE_BINARY \
    --testnet-dir $DATADIR/lighthouse/testnet \
    --debug-level $LOG_LEVEL \
    boot_node \
    --disable-packet-filter \
    --datadir $DATADIR/lighthouse \
    --listen-address $BOOT_NODE_LISTEN_ADDRESS \
    --port $BOOT_NODE_PORT \
    --enr-port $BOOT_NODE_PORT \
    --terminal-total-difficulty-override $TTD_OVERRIDE \
    $BOOT_NODE_IP

cleanup

