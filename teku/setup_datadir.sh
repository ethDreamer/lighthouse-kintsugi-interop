#!/bin/bash
TEKU_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $TEKU_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi
source ./config.env

if [ ! -e $TEKU_DIR/../genesis/generate ]; then
    echo "Error: you must generate beacon state and validators before running this script"
    exit 1
fi

if [ ! -e $TEKU_DIR/../genesis/generate/public ]; then
    echo "Error: beacon state not generated in ../genesis"
    exit 1
fi

SED=$(which gsed 2>/dev/null)
if [ -z "$var" ]; then
	SED=sed
fi

rm -rf $DATADIR
mkdir -p $DATADIR/network && \
	cd $DATADIR/network && \
	cp $TEKU_DIR/../genesis/generate/eth2_config.yaml ./config.yaml && \
	$SED -i "s/TERMINAL_TOTAL_DIFFICULTY:.*/TERMINAL_TOTAL_DIFFICULTY: $TTD_OVERRIDE/" ./config.yaml && \
	$SED -i "/TERMINAL_BLOCK_HASH/d" ./config.yaml && \
	cp $TEKU_DIR/../genesis/generate/public/genesis.ssz . && \
	cd - 1>/dev/null

cd $TEKU_DIR
if [ ! -e ../genesis/generate/private ]; then
    echo "Error: validator keys not generated in ../genesis"
    exit 1
fi

mkdir -p $DATADIR/validators
cd $DATADIR/validators

for full in $(echo $TEKU_DIR/../genesis/generate/private/*); do
	base=$(basename $full);
	mkdir $base && \
		cd $base && \
		cp -r $full/teku-secrets ./secrets && \
		chmod 0600 ./secrets/* && \
		cp -r $full/teku-keys ./keys && \
		cd ..
done


