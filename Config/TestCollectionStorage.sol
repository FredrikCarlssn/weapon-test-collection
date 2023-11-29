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
    mapping(uint256 => Item) public numberToDefaulItem;
    mapping(uint256 => ItemMutables3) public numberToDummieReroll;

    enum DynamicMode {
        VaultMode,
        GameMode,
        Rerolling
    }

    struct ItemConstants {
        string IMG;
        string Name;
        string Type;
        string Class;
    }

    struct Item {
        ItemImmutables Immutables;
        ItemMutables Mutables;
    }

    struct ItemImmutables {
        uint8 ItemConstantsNumber;
        uint8 LootLevel;
        uint8 SeasonLooted;
        uint8 Rarity;
    }

    struct ItemMutables {
        ItemMutables1 Mutables1;
        ItemMutables2 Mutables2;
        ItemMutables3 Mutables3;
        DynamicMode Mode;
    }

    struct ItemMutables1 {
        uint8 MinDamage;
        uint8 MaxDamage;
        uint8 MinPhysicalDamage;
        uint8 MaxPhysicalDamage;
        uint8 MinLightningDamage;
        uint8 MaxLightningDamage;
        uint8 MinAetherealDamage;
        uint8 MaxAetherealDamage;
        uint8 MinFireDamage;
        uint8 MaxFireDamage;
    }

    struct ItemMutables2 {
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
    }

    struct ItemMutables3 {
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
        createMod("MinDamage"); // 1
        createMod("MaxDamage"); // 2
        createMod("Bleed Chance"); // 3
        createMod("Loot Rarity"); // 4
        createMod("Stun Chance"); // 5
        createMod("Brilliance"); // 6
        createMod("Max Life"); // 7
        createMod("Critical Hit Chance"); // 8
        createMod("Max Aether"); // 9
        createMod("Range"); // 10
        createMod("Physical Damage Min"); // 11
        createMod("Physical Damage Max"); // 12
        // Season list
        createSeason("Open Beta"); // 0
        // Rarity
        createRarity("Common"); // 0
        createRarity("Uncommon"); // 1
        createRarity("Rare"); // 2
        createRarity("Legendary"); // 3

        // NFT list
        createMetadata( // 0
            "QmYy1zr6J3LiRJCAF399fKASmUv9cCf2U91PJ5W2ULotWM",
            "Sharpened Chunk of Junk",
            "Saw Blade",
            "1h Sword"
        );
        createMetadata( // 1
            "QmUTeNHrcRZBY5zDwmQHJ3pkSafsLP6JLeG8bvB8zPwH7i",
            "Makeshift Rifle",
            "Rifle",
            "2h Rifle"
        );
        createMetadata( // 2
            "QmXArSWLAiKfaheArcKbMZgsFxBieKMBCNziR8zDpYmCK9",
            "Bulldozer Shotgun",
            "Shotgun",
            "2h Shotgun"
        );
        createMetadata( // 3
            "Qmd7wdKbPPZabYysDqBJd1M71oJ5McuEhRib4raxAkZZmB",
            "Aetherblade Gladius",
            "Heavy Sword",
            "2h Sword"
        );

        numberToDefaulItem[0] = Item({
            Immutables: ItemImmutables({
                ItemConstantsNumber: 0,
                LootLevel: 55,
                SeasonLooted: 0,
                Rarity: 0
            }),
            Mutables: ItemMutables({
                Mutables1: ItemMutables1({
                    MinDamage: 30,
                    MaxDamage: 80,
                    MinPhysicalDamage: 30,
                    MaxPhysicalDamage: 80,
                    MinLightningDamage: 0,
                    MaxLightningDamage: 0,
                    MinAetherealDamage: 0,
                    MaxAetherealDamage: 0,
                    MinFireDamage: 0,
                    MaxFireDamage: 0
                }),
                Mutables2: ItemMutables2({
                    MinColdDamage: 0,
                    MaxColdDamage: 0,
                    AttackSpeed: 23,
                    Range: 25,
                    CriticalHitChance: 10,
                    MinCharacterLevel: 5,
                    MinVitality: 0,
                    MinCaliber: 0,
                    MinTrickery: 0,
                    MinBrilliance: 0
                }),
                Mutables3: ItemMutables3({
                    ModsType1: 10,
                    ModsValue1: 25,
                    ModsType2: 11,
                    ModsValue2: 70,
                    ModsType3: 7,
                    ModsValue3: 6,
                    ModsType4: 9,
                    ModsValue4: 25
                }),
                Mode: DynamicMode.GameMode
            })
        });
        numberToDefaulItem[1] = Item({
            Immutables: ItemImmutables({
                ItemConstantsNumber: 1,
                LootLevel: 38,
                SeasonLooted: 0,
                Rarity: 0
            }),
            Mutables: ItemMutables({
                Mutables1: ItemMutables1({
                    MinDamage: 20,
                    MaxDamage: 60,
                    MinPhysicalDamage: 20,
                    MaxPhysicalDamage: 60,
                    MinLightningDamage: 0,
                    MaxLightningDamage: 0,
                    MinAetherealDamage: 0,
                    MaxAetherealDamage: 0,
                    MinFireDamage: 0,
                    MaxFireDamage: 0
                }),
                Mutables2: ItemMutables2({
                    MinColdDamage: 0,
                    MaxColdDamage: 0,
                    AttackSpeed: 15,
                    Range: 40,
                    CriticalHitChance: 15,
                    MinCharacterLevel: 2,
                    MinVitality: 5,
                    MinCaliber: 0,
                    MinTrickery: 0,
                    MinBrilliance: 0
                }),
                Mutables3: ItemMutables3({
                    ModsType1: 5,
                    ModsValue1: 10,
                    ModsType2: 10,
                    ModsValue2: 10,
                    ModsType3: 7,
                    ModsValue3: 10,
                    ModsType4: 9,
                    ModsValue4: 10
                }),
                Mode: DynamicMode.GameMode
            })
        });
        numberToDefaulItem[2] = Item({
            Immutables: ItemImmutables({
                ItemConstantsNumber: 2,
                LootLevel: 100,
                SeasonLooted: 0,
                Rarity: 2
            }),
            Mutables: ItemMutables({
                Mutables1: ItemMutables1({
                    MinDamage: 10,
                    MaxDamage: 110,
                    MinPhysicalDamage: 10,
                    MaxPhysicalDamage: 100,
                    MinLightningDamage: 0,
                    MaxLightningDamage: 10,
                    MinAetherealDamage: 0,
                    MaxAetherealDamage: 0,
                    MinFireDamage: 0,
                    MaxFireDamage: 0
                }),
                Mutables2: ItemMutables2({
                    MinColdDamage: 0,
                    MaxColdDamage: 0,
                    AttackSpeed: 23,
                    Range: 15,
                    CriticalHitChance: 20,
                    MinCharacterLevel: 80,
                    MinVitality: 0,
                    MinCaliber: 30,
                    MinTrickery: 10,
                    MinBrilliance: 0
                }),
                Mutables3: ItemMutables3({
                    ModsType1: 3,
                    ModsValue1: 10,
                    ModsType2: 11,
                    ModsValue2: 70,
                    ModsType3: 7,
                    ModsValue3: 10,
                    ModsType4: 5,
                    ModsValue4: 10
                }),
                Mode: DynamicMode.GameMode
            })
        });
        numberToDefaulItem[3] = Item({
            Immutables: ItemImmutables({
                ItemConstantsNumber: 3,
                LootLevel: 65,
                SeasonLooted: 0,
                Rarity: 2
            }),
            Mutables: ItemMutables({
                Mutables1: ItemMutables1({
                    MinDamage: 70,
                    MaxDamage: 80,
                    MinPhysicalDamage: 70,
                    MaxPhysicalDamage: 80,
                    MinLightningDamage: 0,
                    MaxLightningDamage: 0,
                    MinAetherealDamage: 0,
                    MaxAetherealDamage: 0,
                    MinFireDamage: 0,
                    MaxFireDamage: 0
                }),
                Mutables2: ItemMutables2({
                    MinColdDamage: 0,
                    MaxColdDamage: 0,
                    AttackSpeed: 30,
                    Range: 15,
                    CriticalHitChance: 30,
                    MinCharacterLevel: 55,
                    MinVitality: 30,
                    MinCaliber: 0,
                    MinTrickery: 0,
                    MinBrilliance: 27
                }),
                Mutables3: ItemMutables3({
                    ModsType1: 10,
                    ModsValue1: 25,
                    ModsType2: 11,
                    ModsValue2: 70,
                    ModsType3: 7,
                    ModsValue3: 6,
                    ModsType4: 9,
                    ModsValue4: 25
                }),
                Mode: DynamicMode.GameMode
            })
        });

        numberToDummieReroll[0] = ItemMutables3({
            ModsType1: 10,
            ModsValue1: 25,
            ModsType2: 11,
            ModsValue2: 70,
            ModsType3: 7,
            ModsValue3: 6,
            ModsType4: 9,
            ModsValue4: 25
        });
        numberToDummieReroll[1] = ItemMutables3({
            ModsType1: 1,
            ModsValue1: 10,
            ModsType2: 2,
            ModsValue2: 20,
            ModsType3: 7,
            ModsValue3: 10,
            ModsType4: 9,
            ModsValue4: 15
        });
        numberToDummieReroll[2] = ItemMutables3({
            ModsType1: 9,
            ModsValue1: 20,
            ModsType2: 11,
            ModsValue2: 20,
            ModsType3: 12,
            ModsValue3: 30,
            ModsType4: 4,
            ModsValue4: 30
        });
        numberToDummieReroll[3] = ItemMutables3({
            ModsType1: 6,
            ModsValue1: 35,
            ModsType2: 4,
            ModsValue2: 20,
            ModsType3: 3,
            ModsValue3: 10,
            ModsType4: 0,
            ModsValue4: 20
        });
        numberToDummieReroll[4] = ItemMutables3({
            ModsType1: 7,
            ModsValue1: 15,
            ModsType2: 5,
            ModsValue2: 30,
            ModsType3: 10,
            ModsValue3: 10,
            ModsType4: 4,
            ModsValue4: 17
        });
    }
}
