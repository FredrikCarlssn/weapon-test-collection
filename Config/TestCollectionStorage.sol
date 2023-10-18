// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestCollectionStorage {
    uint256 s_metaCounter;
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
        createMod("Critical Hit Damage");

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
    }
}
