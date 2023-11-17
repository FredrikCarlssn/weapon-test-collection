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
        mintNft(
            msg.sender,
            0,
            defaultImmutables,
            defaultMutables
        );
    }

    function mintNft(
        address _recipient,
        uint8 _metaDataNumber,
        ItemImmutables memory _itemImmutables,
        ItemMutables memory _itemMutables
      
    ) public nonReentrant onlyOwner {
        uint8 metaDataLenth = getMetaDataLength();
        if (_metaDataNumber > metaDataLenth)
            revert InvalidMetadataNumber(_metaDataNumber);
        if (_recipient == address(0)) revert InvalidAdress(_recipient);

        uint24 tokenId = s_tokenCounter++;

        tokenIdToItemConstantsNumber[tokenId] = _metaDataNumber;
        
        tokenIdToItemImmutables[tokenId] = _itemImmutables;
        
        tokenIdToItemMutables[tokenId] = _itemMutables;

        _safeMint(_recipient, tokenId);
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        ItemConstants storage itemConstants = numberToDefaultMetaData[tokenIdToItemConstantsNumber[_tokenId]];
        ItemImmutables storage itemImmutables = tokenIdToItemImmutables[_tokenId];
        ItemMutables storage itemMutables = tokenIdToItemMutables[_tokenId];

        bytes memory allVariables = constructAttributes(itemConstants, itemImmutables, itemMutables);

        return string(abi.encodePacked(s_baseURI, Base64.encode(allVariables)));
    }

    function constructAttributes(
        ItemConstants storage itemConstants,
        ItemImmutables storage itemImmutables,
        ItemMutables storage itemMutables
    
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
            numberToSeason[itemImmutables.SeasonLooted],
            '"}, {"trait_type": "Rarity", "value": ',
            numberToRarity[itemImmutables.Rarity]
        );
        bytes memory part2 = abi.encodePacked(
            '}, {"trait_type": "MinDamage", "value": "',
            numberToModsType[itemMutables.mutables1.MinDamage],
            '"}, {"trait_type": "MaxDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MaxDamage],
            '}, {"trait_type": "MinPhysicalDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MinPhysicalDamage],
            '}, {"trait_type": "MaxPhysicalDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MaxPhysicalDamage],
            '}, {"trait_type": "MinLigthingDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MinLigthingDamage],
            '}, {"trait_type": "MaxLigthingDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MaxLigthingDamage],
            '}, {"trait_type": "MinAetherealDamage", "value": ',    
            numberToModsType[itemMutables.mutables1.MinAetherealDamage],
            '}, {"trait_type": "MaxAetherealDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MaxAetherealDamage]
        );
        bytes memory part3 = abi.encodePacked(
            '}, {"trait_type": "MinFireDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MinFireDamage],
            '}, {"trait_type": "MaxFireDamage", "value": ',
            numberToModsType[itemMutables.mutables1.MaxFireDamage],
            '}, {"trait_type": "MinColdDamage", "value": ',
            Strings.toString(itemMutables.mutables2.MinColdDamage),
            '}, {"trait_type": "MaxColdDamage", "value": ',
            Strings.toString(itemMutables.mutables2.MaxColdDamage),
            '}, {"trait_type": "AttackSpeed", "value": ',
            Strings.toString(itemMutables.mutables2.AttackSpeed),
            '}, {"trait_type": "Range", "value": ',
            Strings.toString(itemMutables.mutables2.Range),
            '}, {"trait_type": "CriticalHitChance", "value": ',
            Strings.toString(itemMutables.mutables2.CriticalHitChance),
            '}, {"trait_type": "MinCharacterLevel", "value": ',
            Strings.toString(itemMutables.mutables2.MinCharacterLevel)
        );
        bytes memory part4 = abi.encodePacked(    
            '}, {"trait_type": "MinVitality", "value": ',
            Strings.toString(itemMutables.mutables2.MinVitality),
            '}, {"trait_type": "MinCaliber", "value": ',
            Strings.toString(itemMutables.mutables2.MinCaliber),
            '}, {"trait_type": "MinTrickery", "value": ',
            Strings.toString(itemMutables.mutables2.MinTrickery),
            '}, {"trait_type": "MinBrilliance", "value": ',
            Strings.toString(itemMutables.mutables2.MinBrilliance),
            '}, {"trait_type": "ModsType1", "value": ',
            numberToModsType[itemMutables.mutables3.ModsType1],
            '}, {"trait_type": "ModsValue1", "value": ',
            Strings.toString(itemMutables.mutables3.ModsValue1)
        );
        bytes memory part5 = abi.encodePacked(
            '}, {"trait_type": "ModsType2", "value": ',
            numberToModsType[itemMutables.mutables3.ModsType2],
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString(itemMutables.mutables3.ModsValue2),
            '}, {"trait_type": "ModsType3", "value": ',
            numberToModsType[itemMutables.mutables3.ModsType3],
            '}, {"trait_type": "ModsValue3", "value": ',
            Strings.toString(itemMutables.mutables3.ModsValue3),
            '}, {"trait_type": "ModsType4", "value": ',
            numberToModsType[itemMutables.mutables3.ModsType4],
            '}, {"trait_type": "ModsValue4", "value": ',
            Strings.toString(itemMutables.mutables3.ModsValue4),
            "}]}"
        );

        return (
            abi.encodePacked(part1, part2, part3, part4, part5)
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
            defaultMutables
        );
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
