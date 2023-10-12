// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";

contract WeaponTestCollection is ERC721URIStorage, TestCollectionStorage {
    uint256 private s_tokenCounter = 0;

    mapping(uint256 => Item) public tokenIdToItem;

    constructor() ERC721("Weapons Of Shadowrealm", "WOS") {
        uint256 tokenMetaDataLength = tokenMetaData.length;
        for (uint256 i; i < tokenMetaDataLength; i++) {
            mintNft(msg.sender, tokenURIs[i], i);
        }
    }

    function mintNft(
        address _recipient,
        string memory _tokenUri,
        uint256 _metaDataNumber
    ) public payable {
        _mint(_recipient, s_tokenCounter);
        _setTokenURI(s_tokenCounter, _tokenUri);
        tokenIdToItem[s_tokenCounter] = tokenMetaData[_metaDataNumber];
        s_tokenCounter++;
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
