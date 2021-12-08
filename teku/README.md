# Milestone #3: Teku

This contains the scripts required to run Teku for the M3 milestone.

### Build Instructions

```
git clone git@github.com:ConsenSys/teku.git
cd teku
./gradlew distTar installDist
```

This will put the `teku` binary in `./build/install/teku/bin/`

### Set Variables in `config.env`

- `TEKU_BINARY` # path to the the `teku` binary you just built
- `REST_ADDRESS` # bind address for beacon REST API
- `REST_PORT` # port for beacon REST API that the validator will query
- `DISCOVERY_ADDRESS` # bind address for discovery
- `DISCOVERY_TCP` # TCP port to listen for discovery
- `DISCOVERY_UDP` # UDP port to listen for discovery
- `EXECUTION_ENDPOINT` # set to the execution endpoint you want (must be websockets endpoint)

### Generate Universal Beacon State & Validator Keys

Follow the instructions in `../genesis` to generate a universal beacon state
and validator keys. Once you've done that, run the following to setup the teku
directories:
```
$ ./setup_datadir.sh
```
If you simply remove the `$DATADIR`, you will undo this command. You can also rerun
this command to start over from a clean state.

### Start Teku Beacon Node

Run the following in a dedicated terminal:
```
$ ./launch_teku_beacon.sh
```

### Start Teku Validator Node(s)

The keys will be split up among the `$VALIDATOR_NODE_COUNT` validator processes. For
each teku validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $VALIDATOR_NODE_COUNT`

```
$ ./launch_teku_validator.sh [NODE_INDEX]
```

