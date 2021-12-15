#!/bin/bash

BOOTNODE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $BOOTNODE_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $BOOTNODE_DIR/../genesis/generate ]; then
    echo "Error: you must generate beacon state before running this script"
    exit 1
fi

if [ ! -e ../genesis/generate/public ]; then
    echo "Error: beacon state not generated in ../genesis"
    exit 1
fi

rm -rf $DATADIR
mkdir -p $DATADIR/lighthouse/beacon/ && \
	mkdir -p $DATADIR/lighthouse/testnet

cd $DATADIR/lighthouse/testnet && \
	cp $BOOTNODE_DIR/../genesis/generate/eth2_config.yaml ./config.yaml && \
	cp $BOOTNODE_DIR/../genesis/generate/public/genesis.ssz . && \
	echo "0" > deploy_block.txt



