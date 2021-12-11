#!/bin/bash

GENESIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $GENESIS_DIR

if [ ! -e ./config.env ]; then
	echo "did not find ./config.env"
	exit 1
fi

source ./config.env

if [ ! -e $ETH2_TESTNET_GENESIS_BINARY ]; then
	echo "Did not find eth2-testnet-genesis - ensure \$ETH2_TESTNET_GENESIS_BINARY is set correctly in ./config.env"
	exit 1
fi

rm -rf $GENESIS_DIR/eth2/public
mkdir -p $GENESIS_DIR/eth2/public

if [ -z ${GENESIS_TIME} ]; then
    GENESIS_TIME=$(($(date +%s) - $(($(date +%s) % 3600))))
fi
GENESIS_HEX=$(printf '0x%x\n' $GENESIS_TIME)
echo "GENESIS_TIME[$GENESIS_TIME] GENESIS_HEX[$GENESIS_HEX]"

# update eth2 config
sed -i "s/PRESET_BASE:.*/PRESET_BASE: \"$SPEC\"/" ./eth2_config.yaml
sed -i \
	"s/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT:.*/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT: $GENESIS_VALIDATORS/" \
	./eth2_config.yaml
echo "- mnemonic: \"$VALIDATOR_MNEMONIC\"" > ./genesis_validators.yaml
echo "  count: $GENESIS_VALIDATORS" >> ./genesis_validators.yaml

$ETH2_TESTNET_GENESIS_BINARY phase0 \
	 --preset-phase0 $SPEC --preset-altair $SPEC --preset-merge $SPEC \
	 --config "$PWD/eth2_config.yaml" \
	 --mnemonics "$PWD/genesis_validators.yaml" \
	 --timestamp $GENESIS_TIME \
	 --state-output "$PWD/eth2/public/genesis.ssz" \


