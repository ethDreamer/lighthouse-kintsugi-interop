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

if [ ! -e $BESU_BINARY ]; then
	echo "Error: file '$BESU_BINARY' not found."
	echo "Ensure \$BESU_BINARY is set correctly in config.env"
	exit 1
fi

rm -rf $DATADIR && mkdir -p $DATADIR/network

if [[ "$ETH1_CONSENSUS_ALGORITHM" == "clique" ]]; then
	cp ../genesis/network/eth1_config.clique.yaml $DATADIR/network/genesis.json
elif [[ "$ETH1_CONSENSUS_ALGORITHM" == "ethash" ]]; then
	cp ../genesis/network/eth1_config.ethash.yaml $DATADIR/network/genesis.json
else
	echo "Error Unrecognized consensus algorithm: '$ETH1_CONSENSUS_ALGORITHM'"
	echo "Ensure \$ETH1_CONSENSUS_ALGORITHM is propertly set in globals.env"
	exit 1;
fi

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
	--genesis-file=$DATADIR/network/genesis.json \
	--network-id=700



