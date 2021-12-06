#!/bin/bash
LODESTAR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LODESTAR_DIR

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

cd $(dirname $LODESTAR_SCRIPT)
$LODESTAR_SCRIPT \
    --rootDir $DATADIR \
    --paramsFile $DATADIR/eth2_config.yaml \
    beacon \
    --api.rest.api '*' \
    --api.rest.enabled true \
    --api.rest.host $HTTP_LISTEN_ADDRESS \
    --api.rest.port $HTTP_LISTEN_PORT \
    --logLevel $LOG_LEVEL \
    --genesisStateFile $DATADIR/genesis.ssz \
    --enr.ip $DISCOVERY_ADDRESS \
    --enr.tcp $DISCOVERY_TCP \
    --enr.udp $DISCOVERY_UDP \
    --port $DISCOVERY_TCP \
    --discoveryPort $DISCOVERY_UDP \
    --network.discv5.bootEnrs "$BOOT_NODE_ENR" \
    --eth1.enabled true \
    --eth1.providerUrls "$EXECUTION_ENDPOINT" \
    --execution.urls "$EXECUTION_ENDPOINT" \
    --params.TERMINAL_TOTAL_DIFFICULTY $TTD_OVERRIDE

