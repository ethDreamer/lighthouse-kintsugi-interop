#!/bin/bash
PRYSM_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $PRYSM_DIR

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

if [ ! -e $PRYSM_BEACON_BINARY ]; then
	echo "Error: file '$PRYSM_BEACON_BINARY' not found."
	echo "Ensure \$PRYSM_BEACON_BINARY is set correctly in config.env"
	exit 1
fi

echo "Using execution endpoint at: $EXECUTION_ENDPOINT"

$PRYSM_BEACON_BINARY \
	--accept-terms-of-use \
	--bootstrap-node $BOOT_NODE_ENR \
	--chain-config-file $DATADIR/network/config.yaml \
	--datadir $DATADIR \
	--min-sync-peers 1 \
	--interop-genesis-state $DATADIR/network/genesis.ssz \
	--verbosity $VERBOSITY \
	--deposit-contract 0x4242424242424242424242424242424242424242 \
	--contract-deployment-block 2 \
	--p2p-tcp-port $DISCOVERY_TCP \
	--p2p-udp-port $DISCOVERY_UDP \
	--p2p-local-ip $DISCOVERY_ADDRESS \
	--rpc-host $RPC_ADDRESS \
	--rpc-port $RPC_PORT \
	--http-web3provider $EXECUTION_ENDPOINT \
	--enable-debug-rpc-endpoints \
	--terminal-total-difficulty-override $TTD_OVERRIDE


