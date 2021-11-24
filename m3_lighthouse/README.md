# Milestone #3: Lighthouse

This contains the scripts required to run Lighthouse in the M3 milestone.

### Build Instructions

```bash
git clone git@github.com:sigp/lighthouse.git
cd lighthouse
git checkout kintsugi
make
make install-lcli
```

This will install `lighthouse` and `lcli` in `~/.cargo/bin`.

### Set Variables in `../globals.env`

- `LIGHTHOUSE_BINARY` # the defaults should work if you followed instructions above
- `LCLI_BINARY`# the default should work if you followed instructions above
- `LIGHTHOUSE_EE_ENDPOINT` # set to the eth1 endpoint you want to use
- `VALIDATOR_COUNT` # the number of validators in the testnet
- `NODE_COUNT` # the number of beacon nodes (or separate validator processes)
- `TTD_OVERRIDE` # the terminal total difficulty (in decimal)
- `GENESIS_BLOCK_HASH` # (optional) if empty, script will fetch from execution engine
- `GENESIS_TIME` # (optional) if empty, script will round down to the start of the nearest hour

### Generate the beacon state

If `GENESIS_BLOCK_HASH` is not set, you must start your exection node before running this:
```
$ ./gen_beacon_state.sh
```

### Generate the validator keys

```
$ ./gen_validator_keys.sh
```

### Lighthouse beacon node

Run the following in a dedicated terminal:
```
$ ./start_beacon_node.sh
```

### Lighthouse validator node(s)

The keys will be split up among the `$NODE_COUNT` validator processes. For
each lighthouse validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $NODE_COUNT`

```
$ ./start_validator_client.sh [NODE_INDEX]
```

