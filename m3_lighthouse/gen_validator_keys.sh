#!/bin/bash

LIGHTHOUSE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LIGHTHOUSE_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

rm -rf $DATADIR/validators

echo "Generating $VALIDATOR_COUNT validator keypairs..."

$LCLI_BINARY \
	insecure-validators \
	--spec $SPEC \
	--base-dir $DATADIR/validators \
	--count $VALIDATOR_COUNT \
	--node-count $NODE_COUNT \


