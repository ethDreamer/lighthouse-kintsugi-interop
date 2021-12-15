#!/bin/bash

GENESIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $GENESIS_DIR

if [ ! -e ./config.env ]; then
	echo "did not find ./config.env"
	exit 1
fi

source ./config.env

if [ ! -e $ETH2_VAL_TOOLS_BINARY ]; then
	echo "Error: file '$ETH2_VAL_TOOLS_BINARY' not found."
	echo "Ensure \$ETH2_VAL_TOOLS_BINARY is set correctly in config.env"
	exit 1
fi

rm -rf $GENESIS_DIR/generate/private && mkdir $GENESIS_DIR/generate/private

PER_NODE=$(($GENESIS_VALIDATORS / $VALIDATOR_NODE_COUNT))
NODE=0

while [ $NODE -lt $VALIDATOR_NODE_COUNT ]; do
	SRC_MIN=$(($NODE * $PER_NODE));
	SRC_MAX=$(($SRC_MIN + $PER_NODE));
	NODE=$((NODE+1))
	echo "Generating keys for node_$NODE"
	$ETH2_VAL_TOOLS_BINARY keystores \
	  --out-loc "generate/private/node_$NODE" \
	  --prysm-pass="foobar" \
	  --source-min=$SRC_MIN \
	  --source-max=$SRC_MAX \
	  --source-mnemonic="$VALIDATOR_MNEMONIC"
done


