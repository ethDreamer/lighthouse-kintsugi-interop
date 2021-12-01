if [ "$#" -lt 1 ]; then
	echo "usage: $(basename $0) [NODE_INDEX]"
	exit 1
fi

NODE_INDEX=$1
SUFFIX_DIR="node_${NODE_INDEX}"

source ./vars.env

echo "Staring a validator client $NODE_INDEX..."

$LIGHTHOUSE_BINARY \
	--debug-level $DEBUG_LEVEL \
	--datadir $VALIDATOR_DIR/$SUFFIX_DIR \
	vc \
	--testnet-dir $TESTNET_DIR \
	--init-slashing-protection \
	--beacon-nodes http://localhost:5052 \


