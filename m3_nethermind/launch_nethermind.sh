#!/bin/bash

source ../globals.env
source ../execution.env nethermind

DATADIR=$PWD/datadir
rm -rf $DATADIR && mkdir $DATADIR

export DOTNET_ROOT=$DOTNET_ROOT

$NETHERMIND_RUNNER \
	--config $PWD/kintsugi_m3.cfg \
	--datadir $DATADIR \
	--JsonRpc.Host "$JSON_RPC_LISTEN_ADDRESS" \
	--JsonRpc.Port $JSON_RPC_LISTEN_PORT \
	--Network.OnlyStaticPeers true \
  	--Merge.BlockAuthorAccount 0x1000000000000000000000000000000000000000 \
	--Merge.TerminalTotalDifficulty $TTD_OVERRIDE


