# Milestone #3: Geth

### Build Instructions

```bash
git clone git@github.com:MariusVanDerWijden/go-ethereum.git
cd go-ethereum
git checkout beacon-ontopof-4399
make
```

This will install `geth` in `go-ethereum/build/bin/`

### Set Variables in `config.env`

- `GETH_BINARY` # set to path of geth binary you just built
- `DISCOVERY_PORT` # port to listen on for discovery
- `RPC_LISTEN_ADDRESS` # address to listen for incomming JSON-RPC requests
- `RPC_LISTEN_PORT` # TCP port to listen for incomming JSON-RPC requests

### Geth Execution Engine

Run the following in a dedicated terminal:
```
./launch_geth.sh
```

You will be prompted to enter a password for the wallet. You can just press
ENTER a few times. After being dumped into the console you must run
```
miner.start()
```

