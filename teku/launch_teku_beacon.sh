#!/bin/bash
TEKU_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $TEKU_DIR

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

echo "Using execution endpoint at: $EXECUTION_ENDPOINT"

$TEKU_BINARY \
	--data-path $DATADIR \
	--initial-state $DATADIR/network/genesis.ssz \
	--network="$DATADIR/network/config.yaml" \
	--logging=$LOG_LEVEL \
	--p2p-interface $DISCOVERY_ADDRESS \
	--p2p-port $DISCOVERY_TCP \
	--p2p-udp-port $DISCOVERY_UDP \
	--p2p-discovery-bootnodes $BOOT_NODE_ENR \
	--rest-api-enabled true \
	--rest-api-interface $REST_ADDRESS \
	--rest-api-port $REST_PORT \
	--Xee-endpoint="$EXECUTION_ENDPOINT" \
	--eth1-endpoint="$EXECUTION_ENDPOINT" \
	--terminal-total-difficulty-override $TTD_OVERRIDE


