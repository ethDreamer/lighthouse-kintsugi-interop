#!/bin/bash
LODESTAR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LODESTAR_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e ../eth2_gen/eth2 ]; then
    echo "Error: you must generate beacon state and validators before running this script"
    exit 1
fi

if [ ! -e ../eth2_gen/eth2/public ]; then
    echo "Error: beacon state not generated in ../eth2_gen"
    exit 1
fi

rm -rf $DATADIR
mkdir -p $DATADIR && \
	cd $DATADIR && \
	cp ../../eth2_gen/eth2_config.yaml . && \
	cp ../../eth2_gen/eth2/public/genesis.ssz . && \
	cd - 1>/dev/null

cd $LODESTAR_DIR
if [ ! -e ../eth2_gen/eth2/private ]; then
    echo "Error: validator keys not generated in ../eth2_gen"
    exit 1
fi

mkdir -p $DATADIR/validators
cd $DATADIR/validators

for full in $(echo ../../../eth2_gen/eth2/private/*); do
	base=$(basename $full);
	mkdir $base
	cd $base
	cp -r ../$full/lodestar-secrets ./secrets
	cp -r ../$full/keys ./keystores
	cd ..
done



#cd $(dirname $LODESTAR_BINARY)
#$LODESTAR_BINARY --rootDir $DATADIR --paramsFile $DATADIR/eth2_config.yaml init

cd $LODESTAR_DIR
cp ./network/* $DATADIR
