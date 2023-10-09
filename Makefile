-include .env

.PHONY: localDeploy

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

localDeploy: 
	@forge script script/DeployTestCollection.s.sol:DeployTestCollection $(NETWORK_ARGS)