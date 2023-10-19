// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract RandomNumberGeneratorNFT is ERC721Enumerable, Ownable {
    uint256 public randomResult;
    uint256 private seed;

    constructor() ERC721("RandomNFT", "RNFT") {
        seed = block.timestamp;
    }

    function getRandomNumber() public {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(seed, blockhash(block.number-1), block.timestamp, msg.sender))) % 10;
        randomResult = randomNumber;
    }

    function mintNFTs(uint256 numNFTs) public onlyOwner {
        require(numNFTs > 0, "Number of NFTs must be greater than 0");
        for (uint256 i = 0; i < numNFTs; i++) {
            uint256 tokenId = totalSupply() + 1; // Update the tokenId
            _mint(msg.sender, tokenId);
        }
    }
}