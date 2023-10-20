// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract RandomNumberGeneratorNFT is ERC721Enumerable {
    constructor() ERC721("RandomNFT", "RNFT") {}

    function getRandomNumber(uint8 _maxNumber) internal view returns (uint256) {
        uint256 seed = block.timestamp;
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    seed,
                    blockhash(block.number - 1),
                    block.timestamp,
                    msg.sender
                )
            )
        ) % _maxNumber;
        return randomNumber;
    }

    function mintMultipleNFTs(uint256 numNFTs) public {
        for (uint256 i = 0; i < numNFTs; i++) {
            mintNft(msg.sender, getRandomNumber(10));
        }
    }
}
