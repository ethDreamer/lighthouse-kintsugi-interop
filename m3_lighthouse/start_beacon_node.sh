source ./vars.env

echo "Staring lighthouse beacon node using execution engine at $EXECUTION_ENDPOINT..."

$LIGHTHOUSE_BINARY \
    --spec $SPEC \
    --testnet-dir $TESTNET_DIR \
    --debug-level $DEBUG_LEVEL \
    beacon_node \
    --datadir $DATADIR \
    --enr-address  ${DISCOVERY_ADDRESS[lighthouse]} \
    --enr-udp-port ${DISCOVERY_UDP[lighthouse]} \
    --enr-tcp-port ${DISCOVERY_TCP[lighthouse]} \
    --disable-enr-auto-update \
    --port ${DISCOVERY_TCP[lighthouse]} \
    --discovery-port ${DISCOVERY_UDP[lighthouse]} \
    --dummy-eth1 \
    --http-allow-sync-stalled \
    --http \
    --metrics \
    --merge \
    --execution-endpoints $EXECUTION_ENDPOINT \
    --terminal-total-difficulty-override $TTD_OVERRIDE \


