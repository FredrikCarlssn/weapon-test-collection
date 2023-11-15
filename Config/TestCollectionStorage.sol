// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract TestCollectionStorage is Ownable {
    uint8 private s_metaCounter;
    uint8 private s_modsCounter;
    uint8 private s_seasonCounter;
    mapping(uint256 => ItemConstants) public numberToDefaultMetaData;
    mapping(uint8 => string) public numberToModsType;
    mapping(uint8 => string) public numberToSeason;
    mapping(uint8 => string) public numberToRarity;

    ItemMutables immutable defaultMutables =
        ItemMutables({
            MinDamage: 30,
            MaxDamage: 80,
            MinPhysicalDamage: 30,
            MaxPhysicalDamage: 80,
            MinLigthingDamage: 0,
            MaxLigthingDamage: 0,
            MinAetherealDamage: 0, 
            MaxAetherealDamage: 0,
            MinFireDamage: 0,
            MaxFireDamage: 0,
            MinColdDamage: 0,
            MaxColdDamage: 0,
            AttackSpeed: 23,
            Range: 25,
            CriticalHitChance: 10,
            MinCharacterLevel: 5,
            MinVitality: 0,
            MinCaliber: 0,
            MinTrickery: 0,
            MinBrilliance: 0,
            ModsType1: 10, // Physical Damage Min
            ModsValue1: 25,
            ModsType2: 11, // Physical Damage Max
            ModsValue2: 70,
            ModsType3: 7, // Critical Hit Chance
            ModsValue3: 6,
            ModsType4: 9, // Range
            ModsValue4: 25
        });

    ItemImmutables immutable defaultImmutables =
        ItemImmutables({LootLevel: 55, SeasonLooted: 0, Rarity: 2});

    struct ItemConstants {
        string IMG;
        string Name;
        string Type;
        string Class;
    }

    struct ItemImmutables {
        uint8 LootLevel;
        uint8 SeasonLooted;
        uint8 Rarity;
    }

    struct ItemMutables {
        uint8 MinDamage;
        uint8 MaxDamage;
        uint8 MinPhysicalDamage;
        uint8 MaxPhysicalDamage;
        uint8 MinLigthingDamage;
        uint8 MaxLigthingDamage;
        uint8 MinAetherealDamage;
        uint8 MaxAetherealDamage;
        uint8 MinFireDamage;
        uint8 MaxFireDamage;
        uint8 MinColdDamage;
        uint8 MaxColdDamage;
        uint8 AttackSpeed;
        uint8 Range;
        uint8 CriticalHitChance;
        uint8 MinCharacterLevel;
        uint8 MinVitality;
        uint8 MinCaliber;
        uint8 MinTrickery;
        uint8 MinBrilliance;
        uint8 ModsType1;
        uint8 ModsValue1;
        uint8 ModsType2;
        uint8 ModsValue2;
        uint8 ModsType3;
        uint8 ModsValue3;
        uint8 ModsType4;
        uint8 ModsValue4;
    }

    function createMetadata(
        string memory _IMG,
        string memory _Name,
        string memory _Type,
        string memory _Class
    ) public onlyOwner {
        numberToDefaultMetaData[s_metaCounter] = (
            ItemConstants({IMG: _IMG, Name: _Name, Type: _Type, Class: _Class})
        );

        s_metaCounter++;
    }

    function createMod(string memory _modsType) public onlyOwner {
        numberToModsType[s_modsCounter] = _modsType;
        s_modsCounter++;
    }

    function createSeason(string memory _season) public onlyOwner {
        numberToSeason[s_seasonCounter] = _season;
        s_seasonCounter++;
    }

    function createRarity(string memory _rarity) public onlyOwner {
        numberToRarity[s_seasonCounter] = _rarity;
        s_seasonCounter++;
    }

    function getMetaDataLength() public view returns (uint8) {
        return (s_metaCounter - 1);
    }

    function getModLength() public view returns (uint8) {
        return (s_modsCounter - 1);
    }

    function getSeasonLength() public view returns (uint8) {
        return (s_seasonCounter - 1);
    }

    constructor() Ownable(msg.sender) {
        // Mods list
        createMod("Critical Hit Damage"); // 0
        createMod("MinMaxDamage"); // 1
        createMod("Bleed Chance"); // 2
        createMod("Loot Rarity"); // 3
        createMod("Stun Chance"); // 4
        createMod("Brilliance"); // 5
        createMod("Max Life"); // 6
        createMod("Critical Hit Chance"); // 7
        createMod("Max Aether"); // 8
        createMod("Range"); // 9
        createMod("Physical Damage Min"); // 10
        createMod("Physical Damage Max"); // 11
        // Season list
        createSeason("Open Beta"); // 0
        // Rarity
        createRarity("Uncommon"); // 0
        createRarity("Common"); // 1
        createRarity("Rare"); // 2
        createRarity("Legendary"); // 3

        // NFT list
        createMetadata(
            "QmYh6LbBZxuiAN23VdSMv8oXKsQ5S9sFCiC2nwZsd3NSrn",
            "Sharpened Chunk of Junk",
            "Saw Blade",
            "1h Sword"
        );
    }
}
