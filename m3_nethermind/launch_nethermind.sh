#!/bin/bash

NETHERMIND_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $NETHERMIND_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

rm -rf $DATADIR && mkdir $DATADIR

export DOTNET_ROOT=$DOTNET_ROOT

$NETHERMIND_RUNNER \
    --config $PWD/kintsugi_m3.cfg \
    --datadir $DATADIR \
    --JsonRpc.Host "$RPC_LISTEN_ADDRESS" \
    --JsonRpc.Port $RPC_LISTEN_PORT \
    --Network.DiscoveryPort $DISCOVERY_UDP \
    --Network.P2PPort $DISCOVERY_TCP \
    --Network.OnlyStaticPeers true \
    --Merge.BlockAuthorAccount 0x1000000000000000000000000000000000000000 \
    --Merge.TerminalTotalDifficulty $TTD_OVERRIDE


