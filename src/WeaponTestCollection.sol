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
    mapping(uint256 => ItemMutables) public tokenIdToItemMutables;

    constructor() ERC721("NEW", "NWE") {
        // mintNft(msg.sender, 0);
    }

    function mintNft(
        address _recipient,
        uint8 _metaDataNumber,
        uint8 _lootLevel,
        uint8 _seasonLooted,
        uint8 _rarity,
        uint8 _MinDamage,
        uint8 _MaxDamage,
        uint8 _MinPhysicalDamage,
        uint8 _MaxPhysicalDamage,
        uint8 _MinLigthingDamage,
        uint8 _MaxLigthingDamage,
        uint8 _MinAetherealDamage,
        uint8 _MaxAetherealDamage,
        uint8 _MinFireDamage,
        uint8 _MaxFireDamage,
        uint8 _MinColdDamage,
        uint8 _MaxColdDamage,
        uint8 _AttackSpeed,
        uint8 _Range,
        uint8 _CriticalHitChance,
        uint8 _MinCharacterLevel,
        uint8 _MinVitality,
        uint8 _MinCaliber,
        uint8 _MinTrickery,
        uint8 _MinBrilliance,
        uint8 _ModsType1,
        uint8 _ModsValue1,
        uint8 _ModsType2,
        uint8 _ModsValue2,
        uint8 _ModsType3,
        uint8 _ModsValue3,
        uint8 _ModsType4,
        uint8 _ModsValue4
    ) public nonReentrant onlyOwner {
        // uint8 metaDataLenth = getMetaDataLength();
        // if (_metaDataNumber > metaDataLenth)
        //     revert InvalidMetadataNumber(_metaDataNumber);
        // if (_recipient == address(0)) revert InvalidAdress(_recipient);

        uint24 tokenId = s_tokenCounter++;

        tokenIdToItemConstantsNumber[tokenId] = _metaDataNumber;

        tokenIdToItemImmutables[tokenId] = ItemImmutables({
            LootLevel: _lootLevel,
            SeasonLooted: _seasonLooted,
            Rarity: _rarity
        });

        tokenIdToItemMutables[tokenId] = ItemMutables({
            MinDamage: _MinDamage,
            MaxDamage: _MaxDamage,
            MinPhysicalDamage: _MinPhysicalDamage,
            MaxPhysicalDamage: _MaxPhysicalDamage,
            MinLigthingDamage: _MinLigthingDamage,
            MaxLigthingDamage: _MaxLigthingDamage,
            MinAetherealDamage: _MinAetherealDamage,
            MaxAetherealDamage: _MaxAetherealDamage,
            MinFireDamage: _MinFireDamage,
            MaxFireDamage: _MaxFireDamage,
            MinColdDamage: _MinColdDamage,
            MaxColdDamage: _MaxColdDamage,
            AttackSpeed: _AttackSpeed,
            Range: _Range,
            CriticalHitChance: _CriticalHitChance,
            MinCharacterLevel: _MinCharacterLevel,
            MinVitality: _MinVitality,
            MinCaliber: _MinCaliber,
            MinTrickery: _MinTrickery,
            MinBrilliance: _MinBrilliance,
            ModsType1: _ModsType1,
            ModsValue1: _ModsValue1,
            ModsType2: _ModsType2,
            ModsValue2: _ModsValue2,
            ModsType3: _ModsType3,
            ModsValue3: _ModsValue3,
            ModsType4: _ModsType4,
            ModsValue4: _ModsValue4
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

        ItemMutables memory itemMutables = tokenIdToItemMutables[_tokenId];

        (bytes memory part1, bytes memory part2) = constructAttributes(
            itemConstants,
            itemImmutables,
            itemMutables
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
        ItemMutables memory itemMutables
    ) internal view returns (bytes memory part1, bytes memory part2, bytes memory part3, bytes memory part4, bytes memory part5, bytes memory part6, bytes memory part7) {
        part1 = abi.encodePacked(
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
            Strings.toString[ItemImmutables.Loot Level],
            '"}, {"trait_type": "SeasonLooted", "value": "',
            numberToSeason[ItemImmutables.SeasonLooted],
        );
        part2 = abi.encodePacked(
            '"}, {"trait_type": "Rarity", "value": ',
            numberToRarity[ItemImmutables.Rarity],
            '}, {"trait_type": "MinDamage", "value": "',
            numberToModsType[ItemMutables.MinDamage], 
            '"}, {"trait_type": "MaxDamage", "value": ',
            numberToModsType[itemMutables.MaxDamage],
            '}, {"trait_type": "MinPhysicalDamage", "value": ',
            Strings.toString[itemMutables.MinPhysicalDamage],
            '}, {"trait_type": "MaxPhysicalDamage", "value": ',
            Strings.toString[itemMutables.MaxPhysicalDamage],
        );
        part3 = abi.encodePacked(
            '}, {"trait_type": "MinLigthingDamage", "value": ',
            Strings.toString[itemMutables.MinLigthingDamage],
            '}, {"trait_type": "MaxLigthingDamage", "value": ',
            Strings.toString[itemMutables.MaxLigthingDamage],
            '}, {"trait_type": "MinAetherealDamage", "value": ',
            Strings.toString[itemMutables.MinAetherealDamage],
            '}, {"trait_type": "MaxAetherealDamage", "value": ',
            Strings.toString[itemMutables.MaxAetherealDamage],
            '}, {"trait_type": "MinFireDamage", "value": ',
            Strings.toString[itemMutables.MinFireDamage],
        );
        part4 = abi.encodePacked(
            '}, {"trait_type": "MaxFireDamage", "value": ',
            Strings.toString[itemMutables.MaxFireDamage],
            '}, {"trait_type": "MinColdDamage", "value": ',
            Strings.toString[itemMutables.MinColdDamage],
            '}, {"trait_type": "MaxColdDamage", "value": ',
            Strings.toString[itemMutables.MaxColdDamage],
            '}, {"trait_type": "AttackSpeed", "value": ',
            Strings.toString[itemMutables.AttackSpeed],
            '}, {"trait_type": "Range", "value": ',
            Strings.toString[itemMutables.Range],
        );
        part5 = abi.encodePacked(
            '}, {"trait_type": "CriticalHitChance", "value": ',
            Strings.toString[itemMutables.CriticalHitChance],
            '}, {"trait_type": "MinCharacterLevel", "value": ',
            Strings.toString[itemMutables.MinCharacterLevel],
            '}, {"trait_type": "MinVitality", "value": ',
            Strings.toString[itemMutables.MinVitality],
            '}, {"trait_type": "MinCaliber", "value": ',
            Strings.toString[itemMutables.MinCaliber],
            '}, {"trait_type": "MinTrickery", "value": ',
            Strings.toString[itemMutables.MinTrickery],
        );
        part6 = abi.encodePacked(
            '}, {"trait_type": "MinBrilliance", "value": ',
            Strings.toString[itemMutables.MinBrilliance],
            '}, {"trait_type": "ModsType1", "value": ',
            Strings.toString[itemMutables.ModsType1],
            '}, {"trait_type": "ModsValue1", "value": ',
            Strings.toString[itemMutables.ModsValue1],
            '}, {"trait_type": "ModsType2", "value": ',
            Strings.toString[itemMutables.ModsType2],
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString[itemMutables.ModsValue2],
        );
        part7 = abi.encodePacked(
            '}, {"trait_type": "ModsType3", "value": ',
            Strings.toString[itemMutables.ModsType3],
            '}, {"trait_type": "ModsValue3", "value": ',
            Strings.toString[itemMutables.ModsValue3],
            '}, {"trait_type": "ModsType4", "value": ',
            Strings.toString[itemMutables.ModsType4],
            '}, {"trait_type": "ModsValue4", "value": ',
            "}]}"
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

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
