// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract WeaponTestCollection is ERC721, TestCollectionStorage {
    uint256 private s_tokenCounter = 0;
    string private s_baseURI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8v";

    mapping(uint256 => Item) public tokenIdToItem;

    constructor() ERC721("NEW", "NWE") {
        // mintNft(msg.sender, 0);
    }

    function mintNft(address _recipient, uint256 _metaDataNumber) public {
        uint256 tokenId = s_tokenCounter;

        _safeMint(_recipient, tokenId);
        tokenIdToItem[tokenId] = s_metaData[_metaDataNumber];
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        Item memory tokenItem = tokenIdToItem[_tokenId];

        bytes memory part1 = abi.encodePacked(
            tokenItem.IMG,
            '", ',
            '"name": "',
            tokenItem.Name,
            '", ',
            '"description": "',
            tokenItem.Description,
            '", ',
            '"attributes": [{"trait_type": "Type", "value": "',
            tokenItem.Type,
            '"}, {"trait_type": "Tier", "value": ',
            Strings.toString(tokenItem.Tier),
            '}, {"trait_type": "Theme", "value": "'
        );

        bytes memory part2 = abi.encodePacked(
            tokenItem.Theme,
            '"}, {"trait_type": "Family", "value": "',
            tokenItem.Family,
            '"}, {"trait_type": "Damage", "value": ',
            Strings.toString(tokenItem.Damage),
            '}, {"trait_type": "ModsType", "value": "',
            tokenItem.ModsType,
            '"}, {"trait_type": "ModsValue", "value": ',
            Strings.toString(tokenItem.ModsValue),
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString(tokenItem.ModsValue2),
            "}]}"
        );

        return
            string(
                abi.encodePacked(
                    s_baseURI,
                    Base64.encode(bytes(abi.encodePacked(part1, part2)))
                )
            );
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
