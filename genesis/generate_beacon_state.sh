#!/bin/bash

GENESIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $GENESIS_DIR

if [ ! -e ./config.env ]; then
	echo "did not find ./config.env"
	exit 1
fi

source ./config.env

SED=$(which gsed 2>/dev/null)
if [ -z "$var" ]; then
	SED=sed
fi

if [ ! -e $ETH2_TESTNET_GENESIS_BINARY ]; then
	echo "Error: file '$ETH2_TESTNET_GENESIS_BINARY' not found."
	echo "Ensure \$ETH2_TESTNET_GENESIS_BINARY is set correctly in ./config.env"
	exit 1
fi

rm -rf $GENESIS_DIR/generate/public
mkdir -p $GENESIS_DIR/generate/public

if [ -z ${GENESIS_TIME} ]; then
    GENESIS_TIME=$(($(date +%s) - $(($(date +%s) % 3600))))
fi
GENESIS_HEX=$(printf '0x%x\n' $GENESIS_TIME)
echo "GENESIS_TIME[$GENESIS_TIME] GENESIS_HEX[$GENESIS_HEX]"

# update eth2 config
cp $GENESIS_DIR/network/eth2_config.yaml $GENESIS_DIR/generate/eth2_config.yaml && \
	$SED -i "s/PRESET_BASE:.*/PRESET_BASE: \"$SPEC\"/" $GENESIS_DIR/generate/eth2_config.yaml && \
	$SED -i \
		"s/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT:.*/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT: $GENESIS_VALIDATORS/" \
		$GENESIS_DIR/generate/eth2_config.yaml && \
	echo "- mnemonic: \"$VALIDATOR_MNEMONIC\"" > $GENESIS_DIR/generate/genesis_validators.yaml && \
	echo "  count: $GENESIS_VALIDATORS" >> $GENESIS_DIR/generate/genesis_validators.yaml

$ETH2_TESTNET_GENESIS_BINARY phase0 \
	 --preset-phase0 $SPEC --preset-altair $SPEC --preset-merge $SPEC \
	 --config "$PWD/generate/eth2_config.yaml" \
	 --mnemonics "$PWD/generate/genesis_validators.yaml" \
	 --timestamp $GENESIS_TIME \
	 --state-output "$PWD/generate/public/genesis.ssz" \
	 --tranches-dir "$PWD/generate/tranches"


