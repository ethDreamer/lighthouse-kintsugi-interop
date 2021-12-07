#!/bin/bash
source ../globals.env

rm -rf ./eth2/private && mkdir ./eth2/private

PER_NODE=$(($GENESIS_VALIDATORS / $VALIDATOR_NODE_COUNT))
NODE=0

while [ $NODE -lt $VALIDATOR_NODE_COUNT ]; do
	SRC_MIN=$(($NODE * $PER_NODE));
	SRC_MAX=$(($SRC_MIN + $PER_NODE));
	NODE=$((NODE+1))
	echo "Generating keys for node_$NODE"
	eth2-val-tools keystores \
	  --out-loc "eth2/private/node_$NODE" \
	  --source-min=$SRC_MIN \
	  --source-max=$SRC_MAX \
	  --source-mnemonic="$VALIDATOR_MNEMONIC"
done


