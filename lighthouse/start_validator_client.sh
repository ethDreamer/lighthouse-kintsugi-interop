#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "usage: $(basename $0) [NODE_INDEX]"
	exit 1
fi

NODE_INDEX=$1
SUFFIX_DIR="node_${NODE_INDEX}"

LIGHTHOUSE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LIGHTHOUSE_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

echo "Staring a validator client $NODE_INDEX..."

$LIGHTHOUSE_BINARY \
	--debug-level $LOG_LEVEL \
	--datadir $DATADIR/validators/$SUFFIX_DIR \
	vc \
	--testnet-dir $DATADIR/testnet \
	--init-slashing-protection \
	--beacon-nodes $BEACON_ENDPOINT \


