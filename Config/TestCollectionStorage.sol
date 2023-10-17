// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestCollectionStorage {
    Item[] public s_tokenMetaDataArray;

    string constant IPFS = "ipfs:%2f%2f";

    struct Item {
        string IMG;
        string Name;
        string Description;
        string Type;
        uint256 Tier;
        string Theme;
        string Family;
        uint256 Damage;
        string ModsType;
        uint256 ModsValue;
        uint256 ModsValue2;
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
        string memory _ModsType,
        uint256 _ModsValue,
        uint256 _ModsValue2
    ) private {
        s_tokenMetaDataArray.push(
            Item({
                IMG: _IMG,
                Name: _Name,
                Description: _Description,
                Type: _Type,
                Tier: _Tier,
                Theme: _Theme,
                Family: _Family,
                Damage: _Damage,
                ModsType: _ModsType,
                ModsValue: _ModsValue,
                ModsValue2: _ModsValue2
            })
        );
    }

    constructor() {
        s_tokenMetaDataArray.push(
            Item({
                IMG: "QmdYrK5odJEGK2YEEKYcq4VcQqFiGyZES5hrPdHYShPBpG",
                Name: "Stormbreaker Saber",
                Description: "NFT TEST COLLECTION 0x0",
                Type: "1h Sword",
                Tier: 4,
                Theme: "Precision",
                Family: "Potency",
                Damage: 2,
                ModsType: "Critical Hit Damage",
                ModsValue: 15,
                ModsValue2: 0
            })
        );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmYkyf851KWmQhF4DeGjs6uoNtonM7JmkmRh8wFXxR8vZa?filename=0x1.JSON",
        //         4,
        //         6,
        //         "Min Damage & Max Damage",
        //         2,
        //         6
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmZZ8si5MPD6MaT1FrbeqKcg7wtioJScsPQFU3wt3pTP3b?filename=0x2.JSON",
        //         4,
        //         5,
        //         "Bleed Chance",
        //         2,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmNakfRkvfPgUxs7n3QYAfu5iTPx6radifhe6ADvSpFNTw?filename=0x3.JSON",
        //         4,
        //         8,
        //         "Loot Rarity",
        //         75,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmRjEjz2NaT5SsSsrbvApGnLs3ZPD4VCVgYMhik1XuMSUA?filename=0x4.JSON",
        //         4,
        //         9,
        //         "Critical Hit Damage",
        //         25,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmUvu2GQ1GcHsPqNjKbraWcs1TTZJtdWfBuuEHKM1iVScG?filename=0x5.JSON",
        //         4,
        //         20,
        //         "Stun Chance",
        //         25,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmUN1mAsZJBfRnGMtZ7REtS3VYqzCJLogxn9DJYq7jYg9e?filename=0x6.JSON",
        //         4,
        //         0,
        //         "Brilliance",
        //         5,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmPMEgoXzj7mFSyN4HxxAJhLLuz6wd7YjGRenMfM7JTbow?filename=0x7.JSON",
        //         4,
        //         0,
        //         "Max Life",
        //         20,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmYC3Hjc3vHPyiVY7kntb5e6yrMo5wruy1wTAhP1E4CVCc?filename=0x8.JSON",
        //         4,
        //         0,
        //         "Critical Hit Chance",
        //         10,
        //         0
        //     )
        // );
        // tokenMetaData.push(
        //     Item(
        //         "https://ipfs.io/ipfs/QmdZGWu8ddcnJjgzoq2nzyaoq1WCvDbjD64DjyAw57kk9M?filename=0x9.JSON",
        //         4,
        //         0,
        //         "Max Aether",
        //         20,
        //         0
        //     )
        // );
    }
}
