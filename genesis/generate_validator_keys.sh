#!/bin/bash
source ../globals.env

rm -rf ./eth2/private && mkdir ./eth2/private

PER_NODE=$(echo "$GENESIS_VALIDATORS / $VALIDATOR_NODE_COUNT" | bc)
NODE=0

while [ $NODE -lt $VALIDATOR_NODE_COUNT ]; do
	SRC_MIN=$(echo "$NODE * $PER_NODE" | bc);
	SRC_MAX=$(echo "$SRC_MIN + $PER_NODE" | bc);
	NODE=$((NODE+1))
	echo "Generating keys for node_$NODE"
	eth2-val-tools keystores \
	  --out-loc "eth2/private/node_$NODE" \
	  --source-min=$SRC_MIN \
	  --source-max=$SRC_MAX \
	  --source-mnemonic="$VALIDATOR_MNEMONIC"
done


