#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "usage: $0 [NODE_INDEX]"
	exit 1
fi

NIMBUS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $NIMBUS_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $DATADIR ]; then
    echo "Must run setup_datadir.sh before running this"
    exit 1
fi

NODE="node_$1"


$NIMBUS_VALIDATOR_BINARY \
	--data-dir="$DATADIR/validators/$NODE" \
	--log-level=$LOG_LEVEL \
	--beacon-node="$BEACON_ENDPOINT"


