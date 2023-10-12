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
                "https://ipfs.io/ipfs/Qmcj8MVSSUgPAW1YnkVynkV5keYKMjDbGLx4EWDHffrQMh?filename=0x0.JSON",
                4,
                2,
                "Critical Hit Damage",
                15,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmeyxjNogKsNGA14P7djNMQu6Tk6i4BA6H2dPMDCQcZGso?filename=0x1.JSON",
                4,
                6,
                "Min Damage & Max Damage",
                2,
                6
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmehyM9PZq25p3Ss2XwY52fnCjpNa59BD2yTpaf5TbMFoq?filename=0x2.JSON",
                4,
                5,
                "Bleed Chance",
                2,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmeNaZeDbeyMKaQbLAczmNJVATPVGZ2vyMTT2KRM19aBYB?filename=0x3.JSON",
                4,
                8,
                "Loot Rarity",
                75,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmTC4BHDF6SpQPsgV98umRxkUYWRS2wUAKisdjY3bJ2QfN?filename=0x4.JSON",
                4,
                9,
                "Critical Hit Damage",
                25,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmaBRthYaf5P8vnzRb7yBqUyJ32mbSM1X3y8aZ13vT2LAW?filename=0x5.JSON",
                4,
                20,
                "Stun Chance",
                25,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmZStJnqeMVSkiSPm1oqGe1QqLHEctTiJMcUPyToqtQiHn?filename=0x6.JSON",
                4,
                0,
                "Brilliance",
                5,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmP2cYNjQr9pjcfZfLpnGeo1aCRpZNeuCeEAssHLTDAURC?filename=0x7.JSON",
                4,
                0,
                "Max Life",
                20,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmWvzWFLMH3gzf1eQEk3Q3PjNVH5aSTCV8dK6nAb19ecaN?filename=0x8.JSON",
                4,
                0,
                "Critical Hit Chance",
                10,
                0
            )
        );
        tokenMetaData.push(
            Item(
                "https://ipfs.io/ipfs/QmT8jnWGByzhs6ep4SFZXgLmgXYMi5HXqaRA5cVxwF98Rp?filename=0x9.JSON",
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
