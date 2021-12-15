#!/bin/bash
LODESTAR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $LODESTAR_DIR

if [ ! -e ./config.env ]; then
    echo "did not find ./config.env"
    exit 1
fi

source ./config.env

if [ ! -e ../genesis/generate ]; then
    echo "Error: you must generate beacon state and validators before running this script"
    exit 1
fi

if [ ! -e ../genesis/generate/public ]; then
    echo "Error: beacon state not generated in ../genesis"
    exit 1
fi

rm -rf $DATADIR
mkdir -p $DATADIR && \
	cd $DATADIR && \
	cp ../../genesis/generate/eth2_config.yaml . && \
	cp ../../genesis/generate/public/genesis.ssz . && \
	cd - 1>/dev/null

cd $LODESTAR_DIR
if [ ! -e ../genesis/generate/private ]; then
    echo "Error: validator keys not generated in ../genesis"
    exit 1
fi

mkdir -p $DATADIR/validators
cd $DATADIR/validators

for full in $(echo ../../../genesis/generate/private/*); do
	base=$(basename $full);
	mkdir $base
	cd $base
	cp -r ../$full/lodestar-secrets ./secrets
	cp -r ../$full/keys ./keystores
	cd ..
done

cd $(dirname $LODESTAR_SCRIPT)
$LODESTAR_SCRIPT --rootDir $DATADIR --paramsFile $DATADIR/eth2_config.yaml init

