# lighthouse-kintsugi-interop

This is a collection of scripts to easily spin up a multi-client, multi-node
testnet following the [kintsugi spec](https://hackmd.io/@n0ble/kintsugi-spec)
for completion of the [M3 Milestones](https://notes.ethereum.org/@djrtwo/kintsugi-milestones)

See the instructions in the various sub-directories

### General Usage

Steps will generally proceed in the following order:

1. Edit `./globals.env` and set testnet parameters
2. Generate the Beacon State and Validator Keys (see the `genesis` directory)
3. Edit the configuration for each node to contol which CL node points to which EE node
3. Start execution boot node (see the `geth` directory)
4. Start consensus boot node (see the `consensus_bootnode` directory)
5. Start all execution nodes (the execution boot node is already one)
6. Start all consensus beacon nodes
7. Start all validator clients
8. Start mining on the execution boot node

The default configuration is set up so that all clients are using different ports
and can exist on the same machine without modifying any of the default settings.

If more than one node of the same type is needed (eg. 2 geth nodes or 2 lighthouse beacon
nodes), simply make a copy of that node's directory here and edit the `config.env` so
that the ports don't collide with the ports used by the existing node(s) of that type.

Only execution nodes and beacon nodes need thier directories copied; the scripts are set
up so that any number of the same type of validator client can run simultaneously and use
the same beacon node without any of them colliding with one another.

For example, to a configure a testnet with:
- 128 genesis validators
- 4 validator processes (2 lighthouse, 1 lodestar, 1 nimbus)
- 3 beacon nodes (1 lighthouse, 1 lodestar, 1 nimbus)
- 2 geth nodes
- 1 nethermind node

Do the following:
1. Set `GENESIS_VALIDATORS=128` and `VALIDATOR_NODE_COUNT=4` in `./globals.env`
2. Generate a beacon state and validator keys (see instructions in `./genesis`)
3. Create a directory for the second geth node (e.g. `cp -r ./geth ./geth.2`)
4. Edit the ports in `./geth.2/config.env` so they don't collide with the first geth node
5. Edit each beacon node's config so that they all point to their own execution node
   - The execution endpoints are derived from the configs in
     - `./geth/config.env`
     - `./geth.2/config.env`
     - `./nethermind/config.env`
   - Take note of the configuration and set the `$EXECUTION_ENDPOINT` variables accordingly in
     - `./lighthouse/config.env`
     - `./lodestar/config.env`
     - `./nimbus/config.env`
6. Start the consensus boot node in its own shell (see `./consensus_bootnode`)
7. Launch the execution nodes in their own shell (execution bootnode in `./geth` first)
8. Launch the beacon nodes in `./lighthouse` `./lodestar` `./nimbus` in their own shell
10. Launch the validators in their own shell
    - `./lighthouse/start_validator_client.sh 1`
    - `./lighthouse/start_validator_client.sh 2`
    - `./lodestar/launch_lodatar_validator.sh 3`
    - `./nimbus/launch_nimbus_validator 4`
11. In the console for the geth boot node, start mining by running `miner.start()`


