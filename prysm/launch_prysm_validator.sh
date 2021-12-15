#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "usage: $0 [NODE_INDEX]"
	exit 1
fi

PRYSM_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $PRYSM_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $DATADIR ]; then
    echo "Must run setup_datadir.sh before running this"
    exit 1
fi

if [ ! -e $PRYSM_VALIDATOR_BINARY ]; then
	echo "Error: file '$PRYSM_VALIDATOR_BINARY' not found."
	echo "Ensure \$PRYSM_VALIDATOR_BINARY is set correctly in config.env"
	exit 1
fi

DPATH="$DATADIR/validators/node_$1"

echo "Using beacon REST endpoint at: $BEACON_ENDPOINT"

echo "ENTER 'foobar' FOR VALIDATOR PASSWORD!"
$PRYSM_VALIDATOR_BINARY \
	--accept-terms-of-use \
	--datadir $DPATH \
	--wallet-dir "$DPATH/prysm" \
	--verbosity $VERBOSITY \
	--beacon-rpc-provider="$BEACON_ENDPOINT"



