// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestCollectionStorage {
    uint8 s_metaCounter;
    uint256 s_modsCounter;
    mapping(uint256 => ItemConstants) public numberToDefaultMetaData;
    mapping(uint256 => ItemDynamics) public numberToDynamicMetaData;
    mapping(uint256 => string) public numberToModsType;

    struct ItemConstants {
        string IMG;
        string Name;
        string Description;
        string Type;
        uint256 Tier;
        string Theme;
        string Family;
        uint256 Damage;
    }

    struct ItemDynamics {
        uint8 ModsType;
        uint8 ModsValue;
        uint8 ModsValue2;
    }

    function createMetadata(
        string memory _IMG,
        string memory _Name,
        string memory _Description,
        string memory _Type,
        uint256 _Tier,
        string memory _Theme,
        string memory _Family,
        uint256 _Damage,
        uint8 _ModsType,
        uint8 _ModsValue,
        uint8 _ModsValue2
    ) private {
        numberToDefaultMetaData[s_metaCounter] = (
            ItemConstants({
                IMG: _IMG,
                Name: _Name,
                Description: _Description,
                Type: _Type,
                Tier: _Tier,
                Theme: _Theme,
                Family: _Family,
                Damage: _Damage
            })
        );

        numberToDynamicMetaData[s_metaCounter] = (
            ItemDynamics({
                ModsType: _ModsType,
                ModsValue: _ModsValue,
                ModsValue2: _ModsValue2
            })
        );

        s_metaCounter++;
    }

    function createMod(string memory) private {
        numberToModsType[s_modsCounter] = "Critical Hit Damage";
        s_modsCounter++;
    }

    constructor() {
        //Mods types
        createMod("Critical Hit Damage"); // 1
        createMod("MinMaxDamage"); // 2
        createMod("Bleed Chance"); // 3
        createMod("Loot Rarity"); // 4
        createMod("Stun Chance"); // 5
        createMod("Brilliance"); // 6
        createMod("Max Life"); // 7
        createMod("Critical Hit Chance"); // 8
        createMod("Max Aether"); // 9

        //DEFAULT METE DATA FOR ITEMS
             createMetadata(
            "QmdYrK5odJEGK2YEEKYcq4VcQqFiGyZES5hrPdHYShPBpG",
            "Stormbreaker Saber",
            "NFT TEST COLLECTION 0x0",
            "1h Sword",
            4,
            "Precision",
            "Potency",
            2,
            0,
            15,
            0
        );
             createMetadata(
            "QmNnAQA2tQhFKJt81CrPKgVFHPxH9nFFTFCkFkQTWU5SyD",
            "Makeshift Sword",
            "NFT TEST COLLECTION 0x1",
            "1h Sword",
            4,
            "Damage",
            "Potency",
            6,
            1,
            2,
            6
        );
              createMetadata(
            "QmUNWpjD9xKqKk9FqsXPQRFHrB7Wq6bKYFfm2ktxQ7QfBi",
            "Bow of the Frostbound Huntress",
            "NFT TEST COLLECTION 0x2",
            "Bow",
            4,
            "Attack Speed",
            "Potency",
            5,
            3,
            25,
            0
        );
             createMetadata(
            "QmZEEv3CC6JJBhVxrbsqvR33u2D3KAES9DaGCySf7tbx2p",
            "Hammer of the Mountain King",
            "NFT TEST COLLECTION 0x3",
            "2h Mace",
            4,
            "Medium",
            "Potency",
            8,
            4,
            75,
            0
        );
              createMetadata(
            "QmNkwVEd4q7Juwz9ZwMhAZ62Wwu5RPNuYGFeEs3PDrUXJx",
            "Blade of the Eternal Moon",
            "NFT TEST COLLECTION 0x4",
            "2h Sword",
            4,
            "Precision",
            "Potency",
            9,
            1,
            25,
            0
        );
             createMetadata(
            "QmTKxK6mTYKJTYmmisyerUZeQ9AwfN2kFqULMdegT36EDA",
            "Scepter of the Phoenix Flame",
            "NFT TEST COLLECTION 0x5",
            "2h Mace",
            4,
            "Damage",
            "Potency",
            20,
            5,
            25,
            0
        );
             createMetadata(
            "QmctLSryJBYwx3M6gNnUMHzsk5bTspbM5FpyeZYtAztRVy",
            "Dragons Heart Amulet",
            "NFT TEST COLLECTION 0x6",
            "Amulet",
            4,
            "Attack Speed",
            "Brilliance",
            0,
            6,
            5,
            0
        );
                     createMetadata(
            "QmfKRrHRmQV5Vk63Nc98Ltnm1QNxJG1P9yb7ebZuYWBxAS",
            "Luminara's Locket",
            "NFT TEST COLLECTION 0x7",
            "Amulet",
            4,
            "Medium",
            "Potency",
            0,
            7,
            20,
            0
        );
                             createMetadata(
            "QmZTbefAadmcSMW45QW5AqgiQrpa65maLVrTCcSgVomcf8",
            "Tidecaller's Talisman",
            "NFT TEST COLLECTION 0x8",
            "Amulet",
            4,
            "Precision",
            "Resolve",
            0,
            8,
            10,
            0
        );
                             createMetadata(
            "Qmf3dCGwTKJm2WWKfSmDZuPkW4fLWgqcKKu7YqvMThY3PJ",
            "Veil of the Phantom",
            "NFT TEST COLLECTION 0x9",
            "Amulet",
            4,
            "Damage",
            "Resilience",
            0,
            9,
            20,
            0
        );
    }
}

