# Milestone #3: Prysm

This contains the scripts required to run Prysm for the M3 milestone.

### Build Instructions

These instructions are based off of [this guide in the Prysm Documentation](https://docs.prylabs.network/docs/install/install-with-bazel). During the build I ran into an issue with bazel
not being able to download llvm. I fixed it by editing `prysm/WORKSPACE` and chainging the
llvm version to '9.0.0' as [suggested in this comment](https://github.com/prysmaticlabs/prysm/issues/8072#issuecomment-740586904).

```
git clone git@github.com:prysmaticlabs/prysm.git
cd prysm
git checkout kintsugi
bazelisk build //beacon-chain:beacon-chain --config=release
bazelisk build //validator:validator --config=release
```

On my system this put:
- `beacon-chain` binary in `./bazel-bin/cmd/beacon-chain/beacon-chain_/beacon-chain`
- `validator` binary in `./bazel-bin/cmd/validator/validator_/validator`

### Set Variables in `config.env`

- `PRYSM_BEACON_BINARY` # path to the the `beacon-chain` binary you just built
- `PRYSM_VALIDATOR_BINARY` # path to the the `validator` binary you just built
- `REST_ADDRESS` # bind address for beacon REST API
- `REST_PORT` # port for beacon REST API that the validator will query
- `DISCOVERY_ADDRESS` # bind address for discovery
- `DISCOVERY_TCP` # TCP port to listen for discovery
- `DISCOVERY_UDP` # UDP port to listen for discovery
- `EXECUTION_ENDPOINT` # set to the execution endpoint you want (must be websockets endpoint)

### Generate Universal Beacon State & Validator Keys

Follow the instructions in `../genesis` to generate a universal beacon state
and validator keys. Once you've done that, run the following to setup the prysm
directories:
```
$ ./setup_datadir.sh
```
If you simply remove the `$DATADIR`, you will undo this command. You can also rerun
this command to start over from a clean state.

### Start Prysm Beacon Node

Run the following in a dedicated terminal:
```
$ ./launch_prysm_beacon.sh
```

### Start Prysm Validator Node(s)

The keys will be split up among the `$VALIDATOR_NODE_COUNT` validator processes. For
each prysm validator process, you will need to run the following in
a dedicated terminal:

Note: `1 <= NODE_INDEX <= $VALIDATOR_NODE_COUNT`

```
$ ./launch_prysm_validator.sh [NODE_INDEX]
```

Note: the password to decrypt the validators is `foobar`
