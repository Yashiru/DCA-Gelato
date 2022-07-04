# DCA-Gelato
R&D DCA with Gelato
This repository is a Solidity project aiming to create a solution for the creation of 100% automatic DCA positions through the use of Gelato tasks. The project is managed with Foundry.

## Setup project
### Install dependencies

```bash 
forge install https://github.com/smartcontractkit/chainlink.git
forge install https://github.com/OpenZeppelin/openzeppelin-contracts
```

## Run tests
### Without fork
```bash
forge test -vv
```
### With fork
```bash
forge test --fork-url <your_rpc_endpoint> -vv
```

## Deploy
```bash
export ETHERSCAN_API_KEY=<your_etherscan_api_key> && \
forge create src/DcaFactory.sol:DcaFactory \
    --rpc-url <your_rpc_endpoint> \
    --private-key <your_private_key> \
    --constructor-args <gelato_ops> <gelato_address> \
    --verify
```

## DCA architecture
<img src="./static/gelato seq.png" width="100%">

### Legends
- **Final user**: DCA customer
- **Nested DCA**: Nested DCA factory contract
- **Backend**: Nested wwebsite backend
- **Gelato OPS**: Gelato Ops contract that manage all tasks
- **Gelato Network**: The Gelato contract that represent the Gelato network interactivity 
- **Deployed task/DCA contract**: The contract that represent a user DCA position that must be called periodicly
 