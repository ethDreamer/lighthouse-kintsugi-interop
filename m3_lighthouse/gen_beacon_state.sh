source ./vars.env

rm -rf $TESTNET_DIR
rm -rf $BEACON_DIR


if [ -z ${GENESIS_BLOCK_HASH} ]; then
echo "Retrieving genesis block from execution node..."
GENESIS_BLOCK_HASH=$(curl \
	-X \
	POST \
	-H "Content-Type: application/json" \
	--data \
	'{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["earliest",false],"id":1}' \
	$EE_ENDPOINT \
	| jq '.result.hash' \
	| tr -d '"')
else
	echo "WARNING: Using pre-configured Genesis block hash"
fi

if [ -z ${GENESIS_BLOCK_HASH} ]; then exit; fi

echo "Genesis block hash is $GENESIS_BLOCK_HASH"

echo "Generating $SPEC specification and genesis state..."

# round genesis time down to nearest minute..
if [ -z ${GENESIS_TIME} ]; then
GENESIS_TIME=$(echo "$(date +%s) - $(echo "$(date +%s) % 3600" | bc)" | bc)
fi

echo "Using Genesis time: $GENESIS_TIME"

$LCLI_BIN \
	--spec $SPEC \
	new-testnet \
	--genesis-time $GENESIS_TIME \
	--altair-fork-epoch 1 \
	--merge-fork-epoch 2 \
	--interop-genesis-state \
	--validator-count $VALIDATOR_COUNT \
	--min-genesis-active-validator-count $VALIDATOR_COUNT \
	--testnet-dir $TESTNET_DIR \
	--deposit-contract-address 0x0000000000000000000000000000000000000000 \
	--deposit-contract-deploy-block 0 \
	--eth1-block-hash $GENESIS_BLOCK_HASH \

