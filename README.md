# Test NFT collection

Built in foundry

Download here:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

## .ENV

For all deployments to work you need to make an .env file with the following constants:

> WEMIX_TESNET_PRIVATE_KEY = ""
> WEMIX_MAIN_PRIVATE_KEY = ""
> SEPOLIA_TESNET_PRIVATE_KEY = ""
## LIB

It is built with OpenZeppelin library version 4.9.0; Make sure both "openzeppelin-contracts" and "forge-std" libraries are installed in lib folder!

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

> #### Sidenote
>
> This code is not production ready and only produced for testing purpouses.
