-include .env

.PHONY: localDeploy WemixTestDeploy WemixMainDeploy SepoliaTestDeploy test vTest

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

flatten: 
	@forge flatten src/WeaponTestCollection.sol --output flattened.sol

abi: 
	@cast abi-encode "(string, string)" "NEW" "NWE"

test:
	@forge test -vv --gas-report

vTest:
	@forge test -vvvv --gas-report

localDeploy: 
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

WemixTestDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://api.test.wemix.com --private-key $(WEMIX_TESTNET_PRIVATE_KEY) --broadcast --legacy --etherscan-api-key ${WEMIXSCAN_API_KEY} --verify

WemixMainDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://api.wemix.com/ --private-key $(WEMIX_MAIN_PRIVATE_KEY) --broadcast --legacy --etherscan-api-key ${WEMIXSCAN_API_KEY} --verify

SepoliaTestDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://eth-sepolia-public.unifra.io --private-key $(SEPOLIA_TESTNET_PRIVATE_KEY) --broadcast  --etherscan-api-key ${ETHERSCAN_API_KEY} --verify

MumbaiTestDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://polygon-mumbai-bor.publicnode.com --private-key $(MUMBAI_TESTNET_PRIVATE_KEY) --broadcast  --etherscan-api-key ${POLYGONSCAN_API_KEY} --verify
