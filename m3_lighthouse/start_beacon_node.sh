source ./vars.env

EE_PORT=${1:-8545}
EE_ENDPOINT="http://localhost:${EE_PORT}"

echo "Staring a beacon node using an execution engine at $EE_ENDPOINT..."

$LIGHTHOUSE \
	--spec $SPEC \
	--testnet-dir $TESTNET_DIR \
	--debug-level $DEBUG_LEVEL \
	beacon_node \
	--datadir $BEACON_DIR \
	--enr-address 10.26.100.192 \
	--enr-udp-port 9000 \
	--dummy-eth1 \
	--http \
	--http-allow-sync-stalled \
	--metrics \
	--merge \
	--execution-endpoints $EE_ENDPOINT \
	--terminal-total-difficulty-override $TTD_OVERRIDE \


