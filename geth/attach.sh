#!/bin/bash
source ./confg.env
$GETH_BINARY --catalyst --datadir $DATADIR attach
