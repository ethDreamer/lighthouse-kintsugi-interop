#!/bin/bash

LIGHTHOUSE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LIGHTHOUSE_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e $LIGHTHOUSE_DIR/../genesis/eth2 ]; then
    echo "Error: you must generate beacon state and validators before running this script"
    exit 1
fi

rm -rf $DATADIR
mkdir -p $DATADIR/testnet
mkdir -p $DATADIR/beacon
mkdir -p $DATADIR/validators

if [ ! -e ../genesis/eth2/public ]; then
    echo "Error: beacon state not generated in ../genesis"
    exit 1
fi

cd $DATADIR/testnet
echo "[]" > ./boot_enr.yaml
cp $LIGHTHOUSE_DIR/../genesis/eth2_config.yaml ./config.yaml
echo "0" > deploy_block.txt
cp $LIGHTHOUSE_DIR/../genesis/eth2/public/genesis.ssz .

cd $LIGHTHOUSE_DIR
if [ ! -e ../genesis/eth2/private ]; then
    echo "Error: validator keys not generated in ../genesis"
    exit 1
fi

cd $DATADIR/validators
for full in $(echo $LIGHTHOUSE_DIR/../genesis/eth2/private/*); do
	base=$(basename $full);
	mkdir $base
	cd $base
	cp -r $full/secrets .
	cp -r $full/keys ./validators
	cd ..
done


