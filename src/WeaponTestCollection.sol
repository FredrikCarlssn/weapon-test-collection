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
    mapping(uint256 => ItemImmutables) public tokenIdToItemImmutables;
    mapping(uint256 => ItemMutables1) public tokenIdToItemMutables1;
    mapping(uint256 => ItemMutables2) public tokenIdToItemMutables2;

    constructor() ERC721("NEW", "NWE") {
        // mintNft(msg.sender, 0);
    }

    function mintNft(
        address _recipient,
        uint8 _metaDataNumber,
        ItemImmutables memory _itemImmutables,
        ItemMutables1 memory _itemMutables1,
        ItemMutables2 memory _itemMutables2
    ) public nonReentrant onlyOwner {
        // uint8 metaDataLenth = getMetaDataLength();
        // if (_metaDataNumber > metaDataLenth)
        //     revert InvalidMetadataNumber(_metaDataNumber);
        // if (_recipient == address(0)) revert InvalidAdress(_recipient);

        uint24 tokenId = s_tokenCounter++;

        tokenIdToItemConstantsNumber[tokenId] = _metaDataNumber;

        tokenIdToItemImmutables[tokenId] = ItemImmutables({
            LootLevel: _itemImmutables.LootLevel,
            SeasonLooted: _itemImmutables.SeasonLooted,
            Rarity: _itemImmutables.Rarity
        });

        tokenIdToItemMutables1[tokenId] = ItemMutables1({
            MinDamage: _itemMutables1.MinDamage,
            MaxDamage: _itemMutables1.MaxDamage,
            MinPhysicalDamage: _itemMutables1.MinPhysicalDamage,
            MaxPhysicalDamage: _itemMutables1.MaxPhysicalDamage,
            MinLigthingDamage: _itemMutables1.MinLigthingDamage,
            MaxLigthingDamage: _itemMutables1.MaxLigthingDamage,
            MinAetherealDamage: _itemMutables1.MinAetherealDamage,
            MaxAetherealDamage: _itemMutables1.MaxAetherealDamage,
            MinFireDamage: _itemMutables1.MinFireDamage,
            MaxFireDamage: _itemMutables1.MaxFireDamage,
            MinColdDamage: _itemMutables1.MinColdDamage,
            MaxColdDamage: _itemMutables1.MaxColdDamage,
            AttackSpeed: _itemMutables1.AttackSpeed,
            Range: _itemMutables1.Range,
            CriticalHitChance: _itemMutables1.CriticalHitChance
        });

        tokenIdToItemMutables2[tokenId] = ItemMutables2({
            MinCharacterLevel: _itemMutables2.MinCharacterLevel,
            MinVitality: _itemMutables2.MinVitality,
            MinCaliber: _itemMutables2.MinCaliber,
            MinTrickery: _itemMutables2.MinTrickery,
            MinBrilliance: _itemMutables2.MinBrilliance,
            ModsType1: _itemMutables2.ModsType1,
            ModsValue1: _itemMutables2.ModsValue1,
            ModsType2: _itemMutables2.ModsType2,
            ModsValue2: _itemMutables2.ModsValue2,
            ModsType3: _itemMutables2.ModsType3,
            ModsValue3: _itemMutables2.ModsValue3,
            ModsType4: _itemMutables2.ModsType4,
            ModsValue4: _itemMutables2.ModsValue4
        });

        _safeMint(_recipient, tokenId);
    }

    // function mintMultipleNFTs(uint256 numNFTs) public {
    //     for (uint256 i = 0; i < numNFTs; i++) {
    //         mintNft(msg.sender, getRandomNumber(0) );
    //     }
    // }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        ItemConstants memory itemConstants = numberToDefaultMetaData[ //ItemConstansts, ItemImmutabeles, ItemMutables
            tokenIdToItemConstantsNumber[_tokenId]
        ];

        ItemImmutables memory itemImmutables = tokenIdToItemImmutables[
            _tokenId
        ];

        ItemMutables1 memory itemMutables1 = tokenIdToItemMutables1[_tokenId];
        ItemMutables2 memory itemMutables2 = tokenIdToItemMutables2[_tokenId];

        (bytes memory part1, bytes memory part2) = constructAttributes(
            itemConstants,
            itemImmutables,
            itemMutables1,
            itemMutables2
        );

        return
            string(
                abi.encodePacked(
                    s_baseURI,
                    Base64.encode(bytes(abi.encodePacked(part1, part2))) //behövs fler part här
                )
            );
    }

    function constructAttributes(
        ItemConstants memory itemConstants,
        ItemImmutables memory itemImmutables,
        ItemMutables1 memory itemMutables1,
        ItemMutables2 memory itemMutables2
    ) internal view returns (bytes memory part1, bytes memory part2) {
        // part1 = abi.encodePacked(
        //     itemConstants.IMG,
        //     '", ',
        //     '"Name": "',
        //     itemConstants.Name,
        //     '", "attributes": ',
        //     '[{"trait_type": "Type", "value": "',
        //     itemConstants.Type,
        //     '"}, {"trait_type": "Class", "value": ',
        //     itemConstants.Class,
        //     '}, {"trait_type": "Loot Level", "value": "',
        //     itemConstants.Theme,
        //     '"}, {"trait_type": "Family", "value": "',
        //     itemConstants.Family
        // );
        // part2 = abi.encodePacked(
        //     '"}, {"trait_type": "Damage", "value": ',
        //     Strings.toString(itemConstants.Damage),
        //     '}, {"trait_type": "ModsType", "value": "',
        //     numberToModsType[itemDynamics.ModsType], //bort med itemDynamics, in med itemImmutable och itemMutable
        //     '"}, {"trait_type": "ModsValue", "value": ',
        //     Strings.toString(itemMutables.ModsValue),
        //     '}, {"trait_type": "ModsValue2", "value": ',
        //     Strings.toString(itemMutables.ModsValue2),
        //     "}]}"
        // );
    }

    // function getRandomNumber(uint8 max) public returns (uint8) {
    //     uint256 randomnumber = uint256(
    //         keccak256(
    //             abi.encodePacked(
    //                 msg.sender,
    //                 nonce,
    //                 block.timestamp,
    //                 block.number,
    //                 block.prevrandao
    //             )
    //         )
    //     ) % (max + 1);
    //     nonce++;
    //     return uint8(randomnumber);
    // }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
