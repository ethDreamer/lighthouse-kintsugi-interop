#!/bin/bash

source ../globals.env

rm -rf $PWD/eth2/public
mkdir -p eth2/public

if [ -z ${GENESIS_TIME} ]; then
GENESIS_TIME=$(echo "$(date +%s) - $(echo "$(date +%s) % 3600" | bc)" | bc)
fi
GENESIS_HEX=$(printf '0x%x\n' $GENESIS_TIME)
echo "GENESIS_TIME[$GENESIS_TIME] GENESIS_HEX[$GENESIS_HEX]"

# update eth2 config
sed -i "s/PRESET_BASE:.*/PRESET_BASE: \"$SPEC\"/" ./eth2_config.yaml
sed -i \
	"s/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT:.*/MIN_GENESIS_ACTIVE_VALIDATOR_COUNT: $VALIDATOR_COUNT/" \
	./eth2_config.yaml
echo "- mnemonic: \"$VALIDATOR_MNEMONIC\"" > ./genesis_validators.yaml
echo "  count: $VALIDATOR_COUNT" >> ./genesis_validators.yaml

eth2-testnet-genesis phase0 \
	 --preset-phase0 $SPEC --preset-altair $SPEC --preset-merge $SPEC \
	 --config "$PWD/eth2_config.yaml" \
	 --mnemonics "$PWD/genesis_validators.yaml" \
	 --timestamp $GENESIS_TIME \
	 --state-output "$PWD/eth2/public/genesis.ssz" \


