// 1 MinDamage: 30
// 2 MaxDamage: 80
// 3 MinPhysicalDamage: 30
// 4 MaxPhysicalDamage: 80
// 5 MinLightningDamage: 0
// 6 MaxLightningDamage: 0
// 7 MinAetherealDamage: 0
// 8 MaxAetherealDamage: 0
// 9 MinFireDamage: 0
// 10 MaxFireDamage: 0
// 11 MinColdDamage: 0
// 12 MaxColdDamage: 0
// 13 AttackSpeed: 2.3
// 14 Range: 2.5
// 15 CritialHitChance: 10
// 16 MinCharacterLevel: 5
// 17 MinVitality: 0
// 18 MinCaliber:0
// 19 MinTrickery: 0
// 20 MinBrilliance: 0
// 21 ModsType1: Physical Damage Min
// 23 ModsValue1: 25
// 24 ModsType2: Physical Damage Max
// 25 ModsValue2: 70
// 26 ModsType3: Critical Hit Chance
// 27 ModsValue3: 6
// 28 ModsType4: Range
// 29 ModsValue4: 25

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

    ItemImmutables immutable defaultItemImmutables = ItemImmutables(55, 0);

    // Loot Season

    struct ItemConstants {
        string IMG;
        string Name;
        string Type;
        string Class;
        string Rarity;
    }

    struct ItemImmutables {
        uint8 LootLevel;
        uint8 SeasonLooted;
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
        string storage _IMG,
        string storage _Name,
        string memory _Description,
        string memory _Type,
        string memory _Class,
        string memory _Rarity
    ) public onlyOwner {
        numberToDefaultMetaData[s_metaCounter] = (
            ItemConstants({
                IMG: _IMG,
                Name: _Name,
                Description: _Description,
                Type: _Type,
                Class: _Class,
                Rarity: _Rarity
            })
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
    }
}
