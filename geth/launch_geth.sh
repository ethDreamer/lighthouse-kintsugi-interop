#!/bin/bash

GETH_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $GETH_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

rm -rf $DATADIR

if [ "$(basename $GETH_DIR)" != "geth" ]; then
    echo "Running non-boot geth node"
    if [ ! -e $GETH_DIR/../geth/enode.dat ]; then
        echo "Error: must start geth boot node in ../geth before running this";
        exit 1
    fi
fi

# the cli flag is causing seg faults so..
sed -i "s/terminalTotalDifficulty.*/terminalTotalDifficulty\":$TTD_OVERRIDE/" ./genesis.json

$GETH_BINARY \
    --catalyst \
    --http --ws -http.api "engine" \
    --datadir $DATADIR \
    init \
    genesis.json

echo -e "\n" | $GETH_BINARY \
    --catalyst \
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
        --port $DISCOVERY_PORT \
        --datadir $DATADIR \
        console |& grep "enode:" | \
        sed 's/",*//g' > $GETH_DIR/enode.dat
    cleanup() {
        rm -f $GETH_DIR/enode.dat
    }
    trap 'cleanup' SIGINT SIGTERM EXIT
fi

$GETH_BINARY \
    --catalyst \
    --verbosity $VERBOSITY \
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


