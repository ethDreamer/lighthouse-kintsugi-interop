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

### Set Variables in `config.env`

- `LIGHTHOUSE_BINARY` # the defaults should work if you followed instructions above
- `LCLI_BINARY` # (optional) the default should work if you followed instructions above
- `HTTP_LISTEN_ADDRESS` # address to bind to for beacon endpoint validator will use
- `HTTP_LISTEN_PORT` # port to listen for beacon endpoint
- `DISCOVERY_ADDRESS` # address to bind to for discovery
- `DISCOVERY_TCP` # TCP port to listen for discovery
- `DISCOVERY_UDP` # UDP port to listen for discovery
- `EXECUTION_ENDPOINT` # set to the execution endpoint you want to use


### Generate Universal Beacon State & Validator Keys (recommended)

If you want to spin up a testnet with more than just lighthouse consensus clients,
you'll need to use the tools in `../eth2_gen`. Follow instructions in that directory
to generate necessary configuration files and then come back here and run the
following to setup the ligthouse directories:
```
$ ./setup_datadir.sh
```
If you simply remove the `$DATADIR`, you will undo this command.

### Generate Lighthouse-only Beacon State / Validator Keys with `lcli` (optional)

If you only want to use lighthouse as a consensus node and you don't want to install
the dependencies for generating a universal configuration, you can use `lcli`.
You can generate a lighthouse only beacon state using the following command.
Note: If `GENESIS_BLOCK_HASH` is not set, you must start the exection engine that
lighthouse will point to before running this:
```
$ ./gen_beacon_state.sh
```

To generate lighthouse-only validator keys run:
```
$ ./gen_validator_keys.sh
```
If you simply remove the `$DATADIR`, you will undo these commands.

### Start Lighthouse Beacon Node

Run the following in a dedicated terminal:
```
$ ./start_beacon_node.sh
```

### Lighthouse Validator Node(s)

The keys will be split up among the `$NODE_COUNT` validator processes. For
each lighthouse validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $NODE_COUNT`

```
$ ./start_validator_client.sh [NODE_INDEX]
```

