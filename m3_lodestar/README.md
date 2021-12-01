# Milestone #3: Lodestar

This contains the scripts required to run Lodestar in the M3 milestone.

### Build Instructions

TODO

### Set Variables in `../globals.env`

- `LODESTAR_BINARY` # this is the location of the `lodestar` script in the repo
- `TTD_OVERRIDE` # the terminal total difficulty (in decimal)

### Set Variables in `../networking.env` (optional)

- `DISCOVERY_ADDRESS[lodestar]` # address to listen for discovery
- `DISCOVERY_UDP[lodestar]` # UDP port to listen for discovery
- `DISCOVERY_TCP[lodestar]` # TCP port to listen for discovery
- `EE_ENDPOINTS[lodestar]` # set to the execution endpoint you want to use

### Generate Universal Beacon State & Validator Keys (recommended)

Follow the instructions in `../eth2_gen` to generate a universal beacon state
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

The keys will be split up among the `$NODE_COUNT` validator processes. For
each lodestar validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $NODE_COUNT`

```
$ ./launch_lodestar_validator.sh [NODE_INDEX]
```

