# Test NFT collection

Dynamic Non Fungible Token Study. To use intuitive deployment methods, check the MAKEFILE.

Built in foundry

Download here:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

## .ENV

For all deployments to work you need to make an .env file with the following constants:

> WEMIX_TESTNET_PRIVATE_KEY=""
> WEMIX_MAIN_PRIVATE_KEY=""
> SEPOLIA_TESTNET_PRIVATE_KEY=""
> ETHERSCAN_API_KEY=""

## LIB

It is built with OpenZeppelin library version 4.9.0; Make sure both "openzeppelin-contracts" and "forge-std" libraries are installed in lib folder!

If not:
OpenZeppelin-Contracts v.4.9.0:

```bash
forge install OpenZeppelin/openzeppelin-contracts@v4.9.0 --no-commit
```

Forge-std:

```bash
forge install foundry-rs/forge-std --no-commit
```

## Foundry

If you want to learn more about Foundry:
https://book.getfoundry.sh/

# Functions

#### mintNft(address \_recipient, uint256 \_metaDataNumber)

- ETH address for sending the NFT
- Number for nft metadata stored in TestCollectionStorage.sol contract, in a mapping

#### tokenUri(uint256 tokenId)

- Input the tokenId to get the encoded version of the uri. In order to read the Json object that is formatted, copy and paste the encoded file in a browser
- The information in the Jsom is dynamically created from the Item structy in the TestCollectionStorage.sol contract

> #### Sidenote
>
> This code is not production ready and only produced for testing purpouses.
