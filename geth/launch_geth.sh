#!/bin/bash

GETH_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $GETH_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

SED=$(which gsed 2>/dev/null)
if [ -z "$SED" ]; then
	SED=sed
fi

if [ ! -e $GETH_BINARY ]; then
	echo "Error: file '$GETH_BINARY' not found."
	echo "Ensure \$GETH_BINARY is set correctly in config.env"
	exit 1
fi

rm -rf $DATADIR && mkdir -p $DATADIR/network

if [ "$(basename $GETH_DIR)" != "geth" ]; then
    echo "Running non-boot geth node"
    if [ ! -e $GETH_DIR/../geth/enode.dat ]; then
        echo "Error: must start geth boot node in ../geth before running this";
        exit 1
    fi
fi

if [[ "$ETH1_CONSENSUS_ALGORITHM" == "clique" ]]; then
	cp ../genesis/network/eth1_config.clique.yaml $DATADIR/network/genesis.json
elif [[ "$ETH1_CONSENSUS_ALGORITHM" == "ethash" ]]; then
	cp ../genesis/network/eth1_config.ethash.yaml $DATADIR/network/genesis.json
else
	echo "Error Unrecognized consensus algorithm: '$ETH1_CONSENSUS_ALGORITHM'"
	echo "Ensure \$ETH1_CONSENSUS_ALGORITHM is propertly set in globals.env"
	exit 1;
fi

# the cli flag is causing seg faults so..
$SED -i "s/terminalTotalDifficulty.*/terminalTotalDifficulty\":$TTD_OVERRIDE,/" $DATADIR/network/genesis.json

$GETH_BINARY \
    --catalyst \
    --http --ws -http.api "engine" \
    --networkid 700 \
    --datadir $DATADIR \
    init \
    $DATADIR/network/genesis.json

echo -e "\n" | $GETH_BINARY \
    --catalyst \
    --networkid 700 \
    --http --ws -http.api "engine" \
    --datadir $DATADIR \
    account \
    import \
    sk.json

if [ "$(basename $GETH_DIR)" != "geth" ]; then
    cat <<EOF > $DATADIR/geth/static-nodes.json
[
    "$(cat $GETH_DIR/../geth/enode.dat)"
]
EOF
else
    # need to save geth boot node id
    echo -e "\nadmin.nodeInfo.enode" | $GETH_BINARY \
        --catalyst \
        --verbosity 0 \
        --networkid 700 \
        --port $DISCOVERY_PORT \
        --datadir $DATADIR \
        console 2>&1 | grep "enode:" | \
        $SED 's/",*//g' > $GETH_DIR/enode.dat
    cleanup() {
        rm -f $GETH_DIR/enode.dat
    }
    trap 'cleanup' SIGINT SIGTERM EXIT
fi

$GETH_BINARY \
    --catalyst \
    --verbosity $VERBOSITY \
    --networkid 700 \
    --http \
        --http.api "eth,net,engine" \
        --http.addr "$HTTP_RPC_LISTEN_ADDRESS" \
        --http.port $HTTP_RPC_LISTEN_PORT \
    --ws \
        --ws.api "eth,net,engine" \
        --ws.addr "$WS_LISTEN_ADDRESS" \
        --ws.port $WS_LISTEN_PORT \
    --port $DISCOVERY_PORT \
    --datadir $DATADIR \
    --allow-insecure-unlock \
    --unlock "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b" \
    --password "" \
    --nodiscover \
    console


