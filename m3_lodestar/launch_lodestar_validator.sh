#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "usage: $0 [NODE_INDEX]"
	exit 1
fi

NODE="node_$1"

source ./vars.env

cd $(dirname $LODESTAR_BINARY)

$LODESTAR_BINARY \
	--rootDir $DATADIR/validators/$NODE \
	--paramsFile $DATADIR/eth2_config.yaml \
	validator \


