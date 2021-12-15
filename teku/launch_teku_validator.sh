#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "usage: $0 [NODE_INDEX]"
	exit 1
fi

TEKU_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $TEKU_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $DATADIR ]; then
    echo "Must run setup_datadir.sh before running this"
    exit 1
fi

if [ ! -e $TEKU_BINARY ]; then
	echo "Error: file '$TEKU_BINARY' not found."
	echo "Ensure \$TEKU_BINARY is set correctly in config.env"
	exit 1
fi

DPATH="$DATADIR/validators/node_$1"
FEE_ADDRESS=0x0000000000000000000000000000000000000001
#export TEKU_OPTS="-Dlog4j.configurationFile=$TEKU_DIR/log_debug.xml"

echo "Using beacon REST endpoint at: $BEACON_ENDPOINT"

$TEKU_BINARY \
	vc \
	--data-path $DPATH \
	--Xvalidators-suggested-fee-recipient-address="$FEE_ADDRESS" \
	--beacon-node-api-endpoint $BEACON_ENDPOINT \
	--validator-keys="$DPATH/keys:$DPATH/secrets"


