# Ethenaut Bounty: Soulbound NFT

Rinkeby Testnet contract: https://rinkeby.etherscan.io/address/0x59468d1d1e6914012e533bf71e97b05fa610ff36#code
OpenSea NFT Example: https://testnets.opensea.io/assets/0x59468d1d1e6914012e533bf71e97b05fa610ff36/0

## Features

- Only one mint per address
- NFT rendered as dynamic SVG on chain
- SVG based on ERC20 Exp balance

## Getting Started

```sh
forge init
forge build
forge test
```

## Deployment

**VERY IMPORTANT:** DO NOT SHARE YOUR PRIVATE KEY WITH ANYONE and check that they are not on your github project. Use a test wallet to do this.

More info about the Deployment command on the [Foundry book documentation site](https://book.getfoundry.sh/forge/deploying.html?highlight=deploy#deploying).

We are going to deploy this contract on Rinkeby testnet. In order to do that you need to get an RCP_URL from Alchemy or Infura. Replace `YOUR_RINKEBY_RCP_URL` with your own.

```sh
forge create --rpc-url YOUR_RINKEBY_RCP_URL --private-key YOUR_PRIVATE_KEY src/EthernautExp.sol:EthernautExp --constructor-args EXP_ERC20_CONTRACT_ADDRESS
```

## Deployment

More info about the Verifying command on the [Foundry book documentation site](https://book.getfoundry.sh/forge/deploying.html?highlight=deploy#verifying).

We have deployed our contract on Rinkeby. That's why the `chain-id` is set to `4` in the `verify-contract` command.
`YOUR_CONTRACT_ADDRESS` will be the address of the contract on the chain you have deployed it.

```sh
forge verify-contract --chain-id 4 YOUR_CONTRACT_ADDRESS src/EthernautExp.sol:EthernautExp YOUR_ETHERSCAN_API_KEY --constructor-args $(cast abi-encode "constructor(address)" EXP_ERC20_CONTRACT_ADDRESS)
```
