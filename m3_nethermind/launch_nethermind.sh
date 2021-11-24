#!/bin/bash

source ../globals.env

DATADIR=./datadir
rm -rf $DATADIR && mkdir $DATADIR

$NETHERMIND_RUNNER \
	--config $PWD/kintsugi_m3.cfg \
	--datadir $DATADIR \
  	--Merge.BlockAuthorAccount 0x1000000000000000000000000000000000000000 \
	--Merge.TerminalTotalDifficulty $TTD_OVERRIDE


