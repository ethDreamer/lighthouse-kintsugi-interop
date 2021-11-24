source ./vars.env

rm -rf $VALIDATOR_DIR

echo "Generating $VALIDATOR_COUNT validator keypairs..."

$LCLI_BINARY \
	insecure-validators \
	--spec $SPEC \
	--base-dir $VALIDATOR_DIR \
	--count $VALIDATOR_COUNT \
	--node-count $NODE_COUNT \


