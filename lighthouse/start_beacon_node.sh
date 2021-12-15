#!/bin/bash

LIGHTHOUSE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LIGHTHOUSE_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env
source ../bootnode.env

if [ ! -e $DATADIR ]; then
    echo "Must run setup_datadir.sh before running this"
    exit 1
fi

if [ ! -e $LIGHTHOUSE_BINARY ]; then
	echo "Error: file '$LIGHTHOUSE_BINARY' not found."
	echo "Ensure \$LIGHTHOUSE_BINARY is set correctly in config.env"
	exit 1
fi

echo "Using execution engine at $EXECUTION_ENDPOINT..."

$LIGHTHOUSE_BINARY \
    --spec $SPEC \
    --testnet-dir $DATADIR/testnet \
    --debug-level $LOG_LEVEL \
    beacon_node \
    --datadir $DATADIR \
    --boot-nodes $BOOT_NODE_ENR \
    --enr-address  $DISCOVERY_ADDRESS \
    --enr-udp-port $DISCOVERY_UDP \
    --enr-tcp-port $DISCOVERY_TCP \
    --disable-enr-auto-update \
    --port $DISCOVERY_TCP \
    --discovery-port $DISCOVERY_UDP \
    --dummy-eth1 \
    --http-allow-sync-stalled \
    --http \
    --http-address $HTTP_LISTEN_ADDRESS \
    --http-port $HTTP_LISTEN_PORT \
    --merge \
    --execution-endpoints $EXECUTION_ENDPOINT \
    --terminal-total-difficulty-override $TTD_OVERRIDE \


