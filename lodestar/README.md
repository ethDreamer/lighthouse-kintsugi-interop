# Milestone #3: Lodestar

This contains the scripts required to run Lodestar in the M3 milestone.

### Build Instructions

```
git clone https://github.com/chainsafe/lodestar.git
cd lodestar
lerna bootstrap
yarn build
```

Once this is done you should be able to run `./lodestar --help`

### Set Variables in `config.env`

- `LODESTAR_SCRIPT` # this is the location of the `lodestar` script in the root of the lodestar repo
- `HTTP_LISTEN_ADDRESS` # bind address for beacon endpoint the validator will use
- `HTTP_LISTEN_PORT` # port for beacon endpoint
- `DISCOVERY_ADDRESS` # bind address for discovery
- `DISCOVERY_UDP` # UDP port to listen for discovery
- `DISCOVERY_TCP` # TCP port to listen for discovery
- `EXECUTION_ENDPOINT` # set to the execution endpoint you want to use

### Generate Universal Beacon State & Validator Keys

Follow the instructions in `../genesis` to generate a universal beacon state
and validator keys. Once you've done that, run the following to setup the lodestar
directories:
```
$ ./setup_datadir.sh
```
If you simply remove the `$DATADIR`, you will undo this command.

### Start Lodestar Beacon Node

Run the following in a dedicated terminal:
```
$ ./launch_lodestar_beacon.sh
```

### Start Lodestar Validator Node(s)

The keys will be split up among the `$VALIDATOR_NODE_COUNT` validator processes. For
each lodestar validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $VALIDATOR_NODE_COUNT`

```
$ ./launch_lodestar_validator.sh [NODE_INDEX]
```

