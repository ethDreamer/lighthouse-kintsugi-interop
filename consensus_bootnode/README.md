# Consensus Boot Node

This contains the scripts required to run a Lighthouse Boot Node so the consensus nodes can find each other.

### Build Instructions

You need to build the `lighthouse` binary. See instructions in `../lighthouse`

### Set Variables in `config.env`

- `LIGHTHOUSE_BINARY` # path to the lighthouse binary
- `BOOT_NODE_LISTEN_ADDRESS` # address to bind to
- `BOOT_NODE_PORT` # UDP port to listen for connections
- `LOG_LEVEL` # logging verbosity

### Generate Universal Beacon State & Validator Keys

You'll need to use the scripts in `../genesis`. Follow instructions in that directory
to generate necessary configuration files and then come back here and run the
following to setup the boot node directories:
```
$ ./setup_datadir.sh
```
If you simply delete the `$DATADIR`, you will undo this command. You can also erase and
start again from a clean run by running the `setup_datadir.sh` script again.

### Start Lighthouse Boot Node

Run the following in a dedicated terminal:
```
$ ./start_lighthouse_bootnode.sh
```

