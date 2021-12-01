#!/bin/bash
source ../execution.env geth
source ../globals.env

DATADIR="./datadir"
rm -rf $DATADIR
NODEKEY="1edbb645cc15960e246929080cb5802d25a1130d9ef3137ea7c707988e1df7f8"

# the cli flag is causing seg faults so..
sed -i "s/terminalTotalDifficulty.*/terminalTotalDifficulty\":$TTD_OVERRIDE/" ./genesis.json

$GETH_BINARY \
	--catalyst \
	--http --ws -http.api "engine" \
	--datadir $DATADIR \
	init \
	genesis.json

$GETH_BINARY \
	--catalyst \
	--http --ws -http.api "engine" \
	--datadir $DATADIR \
	account \
	import \
	sk.json

echo -n $NODEKEY > $DATADIR/geth/nodekey

$GETH_BINARY \
	--catalyst \
	--http --http.api "engine,eth" \
	--http.addr "$JSON_RPC_LISTEN_ADDRESS" \
	--http.port $JSON_RPC_LISTEN_PORT \
	--datadir $DATADIR \
	--allow-insecure-unlock \
	--unlock "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b" \
	--password "" \
	--nodiscover \
	console

