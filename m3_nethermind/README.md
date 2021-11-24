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

### Set Variables in `../globals.env`

- `DOTNET_ROOT` # ensure you set this correctly based on your dotnet installation
- `NETHERMIND_RUNNER` # set to path of Nerthermind.Runner binary you just built


### Start Geth first (for now)

For now, geth is needed to mine the blocks. See instructions in `../m3_geth`. Once geth is running, nethermind
should find it as a peer.

### Nethermind Execution Engine

Run the following in a dedicated terminal:
```
./launch_nethermind.sh
```


