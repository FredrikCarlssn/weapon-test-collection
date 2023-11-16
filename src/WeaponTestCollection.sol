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
    mapping(uint256 => ItemMutables3) public tokenIdToItemMutables3;

    constructor() ERC721("NEW", "NWE") {
        mintNft(
            msg.sender,
            0,
            defaultImmutables,
            defaultMutables1,
            defaultMutables2,
            defaultMutables3
        );
    }

    function mintNft(
        address _recipient,
        uint8 _metaDataNumber,
        ItemImmutables memory _itemImmutables,
        ItemMutables1 memory _itemMutables1,
        ItemMutables2 memory _itemMutables2,
        ItemMutables3 memory _itemMutables3
    ) public nonReentrant onlyOwner {
        uint8 metaDataLenth = getMetaDataLength();
        if (_metaDataNumber > metaDataLenth)
            revert InvalidMetadataNumber(_metaDataNumber);
        if (_recipient == address(0)) revert InvalidAdress(_recipient);

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
            MaxFireDamage: _itemMutables1.MaxFireDamage
        });

        tokenIdToItemMutables2[tokenId] = ItemMutables2({
            MinColdDamage: _itemMutables2.MinColdDamage,
            MaxColdDamage: _itemMutables2.MaxColdDamage,
            AttackSpeed: _itemMutables2.AttackSpeed,
            Range: _itemMutables2.Range,
            CriticalHitChance: _itemMutables2.CriticalHitChance,
            MinCharacterLevel: _itemMutables2.MinCharacterLevel,
            MinVitality: _itemMutables2.MinVitality,
            MinCaliber: _itemMutables2.MinCaliber,
            MinTrickery: _itemMutables2.MinTrickery,
            MinBrilliance: _itemMutables2.MinBrilliance
        });

        tokenIdToItemMutables3[tokenId] = ItemMutables3({
            ModsType1: _itemMutables3.ModsType1,
            ModsValue1: _itemMutables3.ModsValue1,
            ModsType2: _itemMutables3.ModsType2,
            ModsValue2: _itemMutables3.ModsValue2,
            ModsType3: _itemMutables3.ModsType3,
            ModsValue3: _itemMutables3.ModsValue3,
            ModsType4: _itemMutables3.ModsType4,
            ModsValue4: _itemMutables3.ModsValue4
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
        ItemMutables3 memory itemMutables3 = tokenIdToItemMutables3[_tokenId];

        bytes memory allVariables = constructAttributes(
            itemConstants,
            itemImmutables,
            itemMutables1,
            itemMutables2,
            itemMutables3
        );

        return string(abi.encodePacked(s_baseURI, Base64.encode(allVariables)));
    }

    function constructAttributes(
        ItemConstants memory itemConstants,
        ItemImmutables memory itemImmutables,
        ItemMutables1 memory itemMutables1,
        ItemMutables2 memory itemMutables2,
        ItemMutables3 memory itemMutables3
    ) internal view returns (bytes memory) {
        bytes memory part1 = abi.encodePacked(
            itemConstants.IMG,
            '", ',
            '"Name": "',
            itemConstants.Name,
            '", "attributes": ',
            '[{"trait_type": "Type", "value": "',
            itemConstants.Type,
            '"}, {"trait_type": "Class", "value": ',
            itemConstants.Class,
            '}, {"trait_type": "Loot Level", "value": "',
            Strings.toString(itemImmutables.LootLevel),
            '"}, {"trait_type": "SeasonLooted", "value": "',
            numberToSeason[itemImmutables.SeasonLooted]
        );
        bytes memory part2 = abi.encodePacked(
            '"}, {"trait_type": "Rarity", "value": ',
            numberToRarity[itemImmutables.Rarity],
            '}, {"trait_type": "MinDamage", "value": "',
            numberToModsType[itemMutables1.MinDamage],
            '"}, {"trait_type": "MaxDamage", "value": ',
            numberToModsType[itemMutables1.MaxDamage],
            '}, {"trait_type": "MinPhysicalDamage", "value": ',
            Strings.toString(itemMutables1.MinPhysicalDamage),
            '}, {"trait_type": "MaxPhysicalDamage", "value": ',
            Strings.toString(itemMutables1.MaxPhysicalDamage)
        );
        bytes memory part3 = abi.encodePacked(
            '}, {"trait_type": "MinLigthingDamage", "value": ',
            Strings.toString(itemMutables1.MinLigthingDamage),
            '}, {"trait_type": "MaxLigthingDamage", "value": ',
            Strings.toString(itemMutables1.MaxLigthingDamage),
            '}, {"trait_type": "MinAetherealDamage", "value": ',
            Strings.toString(itemMutables1.MinAetherealDamage),
            '}, {"trait_type": "MaxAetherealDamage", "value": ',
            Strings.toString(itemMutables1.MaxAetherealDamage),
            '}, {"trait_type": "MinFireDamage", "value": ',
            Strings.toString(itemMutables1.MinFireDamage)
        );
        bytes memory part4 = abi.encodePacked(
            '}, {"trait_type": "MaxFireDamage", "value": ',
            Strings.toString(itemMutables1.MaxFireDamage),
            '}, {"trait_type": "MinColdDamage", "value": ',
            Strings.toString(itemMutables2.MinColdDamage),
            '}, {"trait_type": "MaxColdDamage", "value": ',
            Strings.toString(itemMutables2.MaxColdDamage),
            '}, {"trait_type": "AttackSpeed", "value": ',
            Strings.toString(itemMutables2.AttackSpeed),
            '}, {"trait_type": "Range", "value": ',
            Strings.toString(itemMutables2.Range)
        );
        bytes memory part5 = abi.encodePacked(
            '}, {"trait_type": "CriticalHitChance", "value": ',
            Strings.toString(itemMutables2.CriticalHitChance),
            '}, {"trait_type": "MinCharacterLevel", "value": ',
            Strings.toString(itemMutables2.MinCharacterLevel),
            '}, {"trait_type": "MinVitality", "value": ',
            Strings.toString(itemMutables2.MinVitality),
            '}, {"trait_type": "MinCaliber", "value": ',
            Strings.toString(itemMutables2.MinCaliber),
            '}, {"trait_type": "MinTrickery", "value": ',
            Strings.toString(itemMutables2.MinTrickery)
        );
        bytes memory part6 = abi.encodePacked(
            '}, {"trait_type": "MinBrilliance", "value": ',
            Strings.toString(itemMutables2.MinBrilliance),
            '}, {"trait_type": "ModsType1", "value": ',
            numberToModsType[itemMutables3.ModsType1],
            '}, {"trait_type": "ModsValue1", "value": ',
            Strings.toString(itemMutables3.ModsValue1),
            '}, {"trait_type": "ModsType2", "value": ',
            numberToModsType[itemMutables3.ModsType2],
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString(itemMutables3.ModsValue2)
        );
        bytes memory part7 = abi.encodePacked(
            '}, {"trait_type": "ModsType3", "value": ',
            numberToModsType[itemMutables3.ModsType3],
            '}, {"trait_type": "ModsValue3", "value": ',
            Strings.toString(itemMutables3.ModsValue3),
            '}, {"trait_type": "ModsType4", "value": ',
            numberToModsType[itemMutables3.ModsType4],
            "}]}"
        );

        return (
            abi.encodePacked(part1, part2, part3, part4, part5, part6, part7)
        );
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

    function defaultMint() public {
        mintNft(
            msg.sender,
            0,
            defaultImmutables,
            defaultMutables1,
            defaultMutables2,
            defaultMutables3
        );
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
