// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";

error InvalidMetadataNumber(uint8 _metaDataNumber);
error InvalidAdress(address _address);

contract WeaponTestCollection is
    ERC721,
    TestCollectionStorage,
    ReentrancyGuard
{
    uint256 private nonce = 0;
    uint24 private s_tokenCounter;
    string private s_baseURI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8v";

    mapping(uint256 => uint256) public tokenIdToItemConstantsNumber;
    mapping(uint256 => ItemMutables) public tokenIdToItemDynamics;

    constructor() ERC721("NEW", "NWE") {
        // mintNft(msg.sender, 0);
    }

    function mintNft(
        address _recipient,
        uint8 _metaDataNumber
    ) public nonReentrant onlyOwner {
        uint8 metaDataLenth = getMetaDataLength();
        if (_metaDataNumber > metaDataLenth)
            revert InvalidMetadataNumber(_metaDataNumber);
        if (_recipient == address(0)) revert InvalidAdress(_recipient);
        uint24 tokenId = s_tokenCounter++;
        tokenIdToItemConstantsNumber[tokenId] = _metaDataNumber;
        // tokenIdToItemDynamics[tokenId] = numberToDynamicMetaData[
        //     _metaDataNumber
        // ];

        _safeMint(_recipient, tokenId);
    }

    function mintMultipleNFTs(uint256 numNFTs) public {
        for (uint256 i = 0; i < numNFTs; i++) {
            mintNft(msg.sender, getRandomNumber(9));
        }
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        ItemConstants memory itemConstants = numberToDefaultMetaData[
            tokenIdToItemConstantsNumber[_tokenId]
        ];
        ItemDynamics memory itemDynamics = tokenIdToItemDynamics[_tokenId];

        (bytes memory part1, bytes memory part2) = constructAttributes(
            itemConstants,
            itemDynamics
        );

        return
            string(
                abi.encodePacked(
                    s_baseURI,
                    Base64.encode(bytes(abi.encodePacked(part1, part2)))
                )
            );
    }

    function constructAttributes(
        ItemConstants memory itemConstants,
        ItemMutables memory itemMutables
    ) internal view returns (bytes memory part1, bytes memory part2) {
        part1 = abi.encodePacked(
            itemConstants.IMG,
            '", ',
            '"name": "',
            itemConstants.Name,
            '", "description": "',
            itemConstants.Description,
            '", "attributes": ',
            '[{"trait_type": "Type", "value": "',
            itemConstants.Type,
            '"}, {"trait_type": "Tier", "value": ',
            Strings.toString(itemConstants.Tier),
            '}, {"trait_type": "Theme", "value": "',
            itemConstants.Theme,
            '"}, {"trait_type": "Family", "value": "',
            itemConstants.Family
        );
        part2 = abi.encodePacked(
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
    }

    function getRandomNumber(uint8 max) public returns (uint8) {
        uint256 randomnumber = uint256(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    nonce,
                    block.timestamp,
                    block.number,
                    block.prevrandao
                )
            )
        ) % (max + 1);
        nonce++;
        return uint8(randomnumber);
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
