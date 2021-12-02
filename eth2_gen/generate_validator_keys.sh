#!/bin/bash
source ../globals.env

PER_NODE=$(echo "$VALIDATOR_COUNT / $NODE_COUNT" | bc)
NODE=0

while [ $NODE -lt $NODE_COUNT ]; do
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

