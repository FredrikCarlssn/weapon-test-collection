// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestCollectionStorage {
    Item[] public tokenMetaData;
    mapping(uint256 => string) public tokenURIs;

    struct Item {
        string tokenUri;
        uint256 Tier;
        uint256 Damage;
        string ModsType;
        uint256 ModsValue;
        uint256 ModsValue2;
    }

    constructor() {
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmVUKSEnS13fAXqoMw1aZqKppN1NPrd1rjqJEfV9ANgQBi?filename=0x0.JSON",
                4,
                2,
                "Critical Hit Damage",
                15,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmYkyf851KWmQhF4DeGjs6uoNtonM7JmkmRh8wFXxR8vZa?filename=0x1.JSON",
                4,
                6,
                "Min Damage & Max Damage",
                2,
                6
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmZZ8si5MPD6MaT1FrbeqKcg7wtioJScsPQFU3wt3pTP3b?filename=0x2.JSON",
                4,
                5,
                "Bleed Chance",
                2,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmNakfRkvfPgUxs7n3QYAfu5iTPx6radifhe6ADvSpFNTw?filename=0x3.JSON",
                4,
                8,
                "Loot Rarity",
                75,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmRjEjz2NaT5SsSsrbvApGnLs3ZPD4VCVgYMhik1XuMSUA?filename=0x4.JSON",
                4,
                9,
                "Critical Hit Damage",
                25,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmUvu2GQ1GcHsPqNjKbraWcs1TTZJtdWfBuuEHKM1iVScG?filename=0x5.JSON",
                4,
                20,
                "Stun Chance",
                25,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmUN1mAsZJBfRnGMtZ7REtS3VYqzCJLogxn9DJYq7jYg9e?filename=0x6.JSON",
                4,
                0,
                "Brilliance",
                5,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmPMEgoXzj7mFSyN4HxxAJhLLuz6wd7YjGRenMfM7JTbow?filename=0x7.JSON",
                4,
                0,
                "Max Life",
                20,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmYC3Hjc3vHPyiVY7kntb5e6yrMo5wruy1wTAhP1E4CVCc?filename=0x8.JSON",
                4,
                0,
                "Critical Hit Chance",
                10,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmdZGWu8ddcnJjgzoq2nzyaoq1WCvDbjD64DjyAw57kk9M?filename=0x9.JSON",
                4,
                0,
                "Max Aether",
                20,
                0
            )
        );

        for (uint256 i; i < tokenMetaData.length; i++) {
            tokenURIs[i] = tokenMetaData[i].tokenUri;
        }
    }
}
