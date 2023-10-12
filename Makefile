-include .env

.PHONY: localDeploy WemixTestDeploy WemixMainDeploy SepoliaTestDeploy

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

localDeploy: 
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

WemixTestDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://api.test.wemix.com --private-key $(WEMIX_TESTNET_PRIVATE_KEY) --broadcast --legacy

WemixMainDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://api.wemix.com/ --private-key $(WEMIX_MAIN_PRIVATE_KEY) --broadcast --legacy

SepoliaTestDeploy:
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection --rpc-url https://eth-sepolia-public.unifra.io --private-key $(SEPOLIA_TESTNET_PRIVATE_KEY) --broadcast

	