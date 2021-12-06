## Generate eth2 testnet configuration

### Dependencies

- [eth2-testnet-genesis](https://github.com/protolambda/eth2-testnet-genesis)
- [eth2-val-tools](https://github.com/protolambda/eth2-val-tools)

### Set Variables in `../globals.env`

- `SPEC` # 'mainnet' or 'minimal'
- `GENESIS_VALIDATORS` # validators included at genesis
- `VALIDATOR_NODE_COUNT` # number of validator nodes (ensure `GENESIS_VALIDATORS` % `VALIDATOR_NODE_COUNT` == 0)
- `TTD_OVERRIDE` # Terminal Total Difficulty Override (in decimal)
- `VALIDATOR_MNEMONIC` # the mnemonic from which to generate the validators
- `GENESIS_TIME` # (optional) if empty, script will round down to start of the nearest hour

### Generate Configuration, Genesis State, and Validators

```
$ ./generate_beacon_state.sh && ./generate_validator_keys.sh
```


