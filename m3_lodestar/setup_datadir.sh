#!/bin/bash
source ./vars.env

rm -rf $DATADIR
mkdir -p $DATADIR && \
	cd $DATADIR && \
	ln -s ../../eth2_gen/eth2_config.yaml && \
	ln -s ../../eth2_gen/eth2/public/genesis.ssz .
	cd - 1>/dev/null

mkdir -p $DATADIR/validators
cd $DATADIR/validators

for full in $(echo ../../../eth2_gen/eth2/private/*); do
	base=$(basename $full);
	mkdir $base
	cd $base
	ln -s ../$full/lodestar-secrets ./secrets
	ln -s ../$full/keys ./keystores
	cd ..
done

#cd $(dirname $LODESTAR_BINARY)
#$LODESTAR_BINARY --rootDir $DATADIR --paramsFile $DATADIR/eth2_config.yaml init
#cd - 1>/dev/null
cd ../../
cp ./network/* $DATADIR
