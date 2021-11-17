#!/bin/bash

NETHERMIND_BIN=/home/mark/ethereum/development/kintsugi/nethermind/src/Nethermind/Nethermind.Runner/bin/Release/net5.0/Nethermind.Runner
DATADIR=./datadir
export DOTNET_ROOT=$HOME/.dotnet

rm -rf $DATADIR && mkdir $DATADIR

cat <<EOF > $DATADIR/static-nodes.json
[
	"enode://9102f063c9be8a4da4c8851e2b05e162f9a450dd95c5c9b4987ebd196fdf0a7e0f8a0ef7e47feb33e459e242b0fda6a6f4b0adfb0f638eacd07cb929f36427b9@127.0.0.1:30303",
]
EOF

$NETHERMIND_BIN \
	--Init.StaticNodesPath "$DATADIR/static-nodes.json" \
	--config $PWD/themerge_kintsugi_m2.cfg \
	--datadir $DATADIR \
  	--Merge.BlockAuthorAccount 0x1000000000000000000000000000000000000000 \
	--Merge.TerminalTotalDifficulty 42


