#!/bin/bash

BESU_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $BESU_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $BESU_DIR/../geth/enode.dat ]; then
    echo "Error: must start geth boot node in ../geth before running this";
    exit 1
fi

rm -rf $DATADIR && mkdir $DATADIR

#BOOTNODE=$(cat $BESU_DIR/../geth/enode.dat)
cat <<EOF > $DATADIR/static-nodes.json
[
    "$(cat $BESU_DIR/../geth/enode.dat)"
]
EOF

$BESU_BINARY \
	--data-path=$DATADIR \
	--logging=$LOG_LEVEL \
	--rpc-http-enabled=true \
	--rpc-http-host="$RPC_LISTEN_ADDRESS" \
	--rpc-http-port=$RPC_LISTEN_PORT \
	--rpc-http-apis="ETH,ADMIN,NET,DEBUG,TXPOOL,EXECUTION" \
	--p2p-port=$DISCOVERY_PORT \
	--Xmerge-support=true \
	--miner-coinbase fe3b557e8fb62b89f4916b721be55ceb828dbd73 \
	--genesis-file=$BESU_DIR/genesis.json \
	--network-id=1



