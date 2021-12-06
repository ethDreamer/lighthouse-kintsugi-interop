# Milestone #3: Nimbus

This contains the scripts required to run Nimbus for the M3 milestone.

### Build Instructions

```
git clone git@github.com:status-im/nimbus-eth2.git
cd nimbus-eth2
git checkout kintsugi
make -j8 nimbus_beacon_node nimbus_validator_client
```

This will put two binaries `nimbus_beacon_node` & `nimbus_validator_client` in ./build/

### Set Variables in `config.env`

- `NIMBUS_BEACON_BINARY` # path to the the `nimbus_beacon_node` binary
- `NIMBUS_VALIDATOR_BINARY` # path to the `nimbus_validator_client` binary
- `RPC_LISTEN_ADDRESS` # bind address for [JSON-RPC API](https://nimbus.guide/api.html)
- `RPC_PORT` # bind port for JSON-RPC API
- `REST_ADDRESS` # bind address for [REST API](https://nimbus.guide/rest-api.html)
- `REST_PORT` # port for rest API the validator will query
- `DISCOVERY_ADDRESS` # bind address for discovery
- `DISCOVERY_TCP` # TCP port to listen for discovery
- `DISCOVERY_UDP` # UDP port to listen for discovery
- `EXECUTION_ENDPOINT` # set to the execution endpoint you want (must be websockets endpoint)

### Generate Universal Beacon State & Validator Keys

Follow the instructions in `../genesis` to generate a universal beacon state
and validator keys. Once you've done that, run the following to setup the nimbus
directories:
```
$ ./setup_datadir.sh
```
If you simply remove the `$DATADIR`, you will undo this command. You can also rerun
this command to start over from a clean state.

### Start Nimbus Beacon Node

Run the following in a dedicated terminal:
```
$ ./launch_nimbus_beacon.sh
```

### Start Nimbus Validator Node(s)

The keys will be split up among the `$VALIDATOR_NODE_COUNT` validator processes. For
each nimbus validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $VALIDATOR_NODE_COUNT`

```
$ ./launch_nimbus_validator.sh [NODE_INDEX]
```

