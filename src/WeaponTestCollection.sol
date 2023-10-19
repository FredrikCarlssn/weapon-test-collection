// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract WeaponTestCollection is ERC721, TestCollectionStorage {
    uint24 private s_tokenCounter = 0;
    string private s_baseURI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8v";

    mapping(uint256 => uint256) public tokenIdToItemConstantsNumber;
    mapping(uint256 => ItemDynamics) public tokenIdToItemDynamics;

    constructor() ERC721("NEW", "NWE") {
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
        mintNft(msg.sender, 0);
    }

    function mintNft(address _recipient, uint8 _metaDataNumber) public {
        uint24 tokenId = s_tokenCounter;
        _safeMint(_recipient, tokenId);
        tokenIdToItemConstantsNumber[tokenId] = _metaDataNumber;
        tokenIdToItemDynamics[tokenId] = numberToDynamicMetaData[
            _metaDataNumber
        ];
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        ItemConstants memory itemConstants = numberToDefaultMetaData[
            tokenIdToItemConstantsNumber[_tokenId]
        ];
        ItemDynamics memory itemDynamics = tokenIdToItemDynamics[_tokenId];

        bytes memory part1 = abi.encodePacked(
            itemConstants.IMG,
            '", ',
            '"name": "',
            itemConstants.Name,
            '", ',
            '"description": "',
            itemConstants.Description,
            '", ',
            '"attributes": [{"trait_type": "Type", "value": "',
            itemConstants.Type,
            '"}, {"trait_type": "Tier", "value": ',
            Strings.toString(itemConstants.Tier),
            '}, {"trait_type": "Theme", "value": "'
        );

        bytes memory part2 = abi.encodePacked(
            itemConstants.Theme,
            '"}, {"trait_type": "Family", "value": "',
            itemConstants.Family,
            '"}, {"trait_type": "Damage", "value": ',
            Strings.toString(itemConstants.Damage),
            '}, {"trait_type": "ModsType", "value": "',
            numberToModsType[itemDynamics.ModsType],
            '"}, {"trait_type": "ModsValue", "value": ',
            Strings.toString(itemDynamics.ModsValue),
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString(itemDynamics.ModsValue2),
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
