#!/bin/bash

NETHERMIND_BIN=/home/mark/ethereum/development/kintsugi/nethermind/src/Nethermind/Nethermind.Runner/bin/Release/net5.0/Nethermind.Runner
DATADIR=./datadir
export DOTNET_ROOT=$HOME/.dotnet

rm -rf $DATADIR && mkdir $DATADIR

$NETHERMIND_BIN \
	--config $PWD/kintsugi_m3.cfg \
	--datadir $DATADIR \
  	--Merge.BlockAuthorAccount 0x1000000000000000000000000000000000000000 \
	--Merge.TerminalTotalDifficulty 100000000


