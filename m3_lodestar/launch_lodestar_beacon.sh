#!/bin/bash
source ./vars.env

cd $(dirname $LODESTAR_BINARY)

BOOT_ENRS="enr:-Ly4QPOzB5o4ldodVGk2MK9ms-E8NL6NYHBz8xGBiy-am9vYZ0zHX7TQDM--XtLb48jg9N6oOdMvwBmZ3DtDFY9dmzcCh2F0dG5ldHOIAAAAAAAAAACEZXRoMpCSRWn8AgAAAf__________gmlkgnY0gmlwhH8AAAGJc2VjcDI1NmsxoQJmMbzA19NBqAFPuBQZiLsQT-BQ1FOQyzElspkbYm2JSYhzeW5jbmV0cwCDdGNwgiMog3VkcIIjKA"

$LODESTAR_BINARY \
    --rootDir $DATADIR \
    --paramsFile $DATADIR/eth2_config.yaml \
    beacon \
	--eth1.enabled false \
	--api.rest.api '*' \
	--api.rest.enabled true \
	--api.rest.host 127.0.0.1 \
	--api.rest.port 9596 \
    --logLevel info \
    --genesisStateFile $DATADIR/genesis.ssz \
    --enr.ip ${DISCOVERY_ADDRESS[lodestar]} \
    --enr.tcp ${DISCOVERY_TCP[lodestar]} \
    --enr.udp ${DISCOVERY_UDP[lodestar]} \
    --port ${DISCOVERY_TCP[lodestar]} \
    --discoveryPort ${DISCOVERY_UDP[lodestar]} \
    --network.localMultiaddrs "/ip4/127.0.0.1/tcp/9000/p2p/16Uiu2HAm2JbZ2unKEs6A1QiKaFyKrZZgLkafNwzBgxyZARXgF5be" \
    --network.discv5.bootEnrs "$BOOT_ENRS" \
    --network.connectToDiscv5Bootnodes true \
    --execution.urls "$EXECUTION_ENDPOINT"


#    --network.bootMultiaddrs "/ip4/127.0.0.1/tcp/9000/p2p/16Uiu2HAm2JbZ2unKEs6A1QiKaFyKrZZgLkafNwzBgxyZARXgF5be" \


