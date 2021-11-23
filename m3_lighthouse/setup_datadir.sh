#!/bin/bash
source ./vars.env

rm -rf $DATA_DIR
mkdir -p $TESTNET_DIR

cd $TESTNET_DIR
echo "[]" > ./boot_enr.yaml
ln -s ../../../eth2_gen/eth2_config.yaml ./config.yaml
echo "0" > deploy_block.txt
ln -s ../../../eth2_gen/eth2/public/genesis.ssz .

mkdir -p $VALIDATOR_DIR
cd $VALIDATOR_DIR
for full in $(echo ../../../eth2_gen/eth2/private/*); do
	base=$(basename $full);
	mkdir $base
	cd $base
	ln -s ../$full/secrets .
	ln -s ../$full/keys ./validators
	cd ..
done


