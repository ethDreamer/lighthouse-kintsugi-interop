#!/bin/bash
NIMBUS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $NIMBUS_DIR

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

$NIMBUS_BEACON_BINARY \
	--data-dir="$DATADIR/beacon" \
	--network="$DATADIR/network" \
	--in-process-validators=false \
	--rpc \
	--rpc-address="$RPC_LISTEN_ADDRESS" \
	--rpc-port=$RPC_PORT \
	--log-level=$LOG_LEVEL \
	--listen-address="$DISCOVERY_ADDRESS" \
	--nat="extip:$DISCOVERY_ADDRESS" \
    --tcp-port=$DISCOVERY_TCP \
    --udp-port=$DISCOVERY_UDP \
	--discv5=true \
    --web3-url="$EXECUTION_ENDPOINT" \
	--bootstrap-node="$BOOT_NODE_ENR" \
	--subscribe-all-subnets \
	--rest \
	--max-peers=2 \
	--rest-address="$REST_ADDRESS" \
	--rest-port=$REST_PORT

#    --eth1.enabled true \
#    --execution.urls "$EXECUTION_ENDPOINT" \
#    --params.TERMINAL_TOTAL_DIFFICULTY $TTD_OVERRIDE
