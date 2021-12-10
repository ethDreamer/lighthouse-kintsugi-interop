# Milestone #3: Nethermind

### Build Instructions

```bash
git clone https://github.com/NethermindEth/nethermind --recursive
cd nethermind/src/Nethermind
git checkout themerge_kintsugi
dotnet build Nethermind.sln -c Release
dotnet build Nethermind.sln -c Release # idk why it needs to be run twice..
```

This will install `Nethermind.Runner` in `nethermind/src/Nethermind/Nethermind.Runner/bin/Release/net*/Nethermind.Runner`

### Set Variables in `config.env`

- `DOTNET_ROOT` # ensure you set this correctly based on your dotnet installation
- `NETHERMIND_RUNNER` # set to path of Nerthermind.Runner binary you just built
- `DISCOVERY_TCP` # TCP port to listen on for discovery
- `DISCOVERY_UDP` # UDP port to listen on for discovery
- `RPC_LISTEN_ADDRESS` # address to bind to for JSON-RPC endpoint
- `PRC_LISTEN_PORT` # port to listen on for JSON-RPC endpoint

### Start Geth first

geth is needed both to mine the blocks and act as a bootnode for the execution engines. See
instructions in `../geth`. Once the geth bootnode is running, nethermind should find it as
a peer.

### Nethermind Execution Engine

Run the following in a dedicated terminal:
```
./launch_nethermind.sh
```


