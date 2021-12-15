#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "usage: $0 [NODE_INDEX]"
	exit 1
fi

LODESTAR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LODESTAR_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $DATADIR ]; then
    echo "Must run setup_datadir.sh before running this"
    exit 1
fi

if [ ! -e $LODESTAR_SCRIPT ]; then
	echo "Error: file '$LODESTAR_SCRIPT' not found."
	echo "Ensure \$LODESTAR_SCRIPT is set correctly in config.env"
	exit 1
fi

NODE="node_$1"

cd $(dirname $LODESTAR_SCRIPT)

$LODESTAR_SCRIPT \
	--rootDir $DATADIR/validators/$NODE \
	--paramsFile $DATADIR/eth2_config.yaml \
	validator \
	--logLevel $LOG_LEVEL \
	--params.TERMINAL_TOTAL_DIFFICULTY $TTD_OVERRIDE \
	--server $BEACON_ENDPOINT


