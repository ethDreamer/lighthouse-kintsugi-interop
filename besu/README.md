# Milestone #3: Besu

### Build Instructions

```bash
git clone git@github.com:hyperledger/besu.git
cd besu
git checkout merge
./gradlew --parallel installDist
```

This will install `besu` in `build/install/besu/bin/besu`

### Set Variables in `config.env`

- `BESU_BINARY` # path to besu binary you just built
- `DISCOVERY_PORT` # port to listen on for discovery
- `RPC_LISTEN_ADDRESS` # address to bind to for JSON-RPC endpoint
- `PRC_LISTEN_PORT` # port to listen on for JSON-RPC endpoint

### Start Geth first

geth is needed both to mine the blocks and act as a bootnode. See instructions in `../geth`.
Once geth is running, besu should find it as a peer.

### Besu Execution Engine

Run the following in a dedicated terminal:
```
./launch_besu.sh
```


