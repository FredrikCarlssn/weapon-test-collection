// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestCollectionStorage {
    mapping(uint256 => string) public tokenURIs;
    uint256 internal s_URILength;

    constructor() {
        tokenURIs[
            0
        ] = "https://ipfs.io/ipfs/Qmcj8MVSSUgPAW1YnkVynkV5keYKMjDbGLx4EWDHffrQMh?filename=0x0.JSON";
        tokenURIs[
            1
        ] = "https://ipfs.io/ipfs/QmeyxjNogKsNGA14P7djNMQu6Tk6i4BA6H2dPMDCQcZGso?filename=0x1.JSON";
        tokenURIs[
            2
        ] = "https://ipfs.io/ipfs/QmehyM9PZq25p3Ss2XwY52fnCjpNa59BD2yTpaf5TbMFoq?filename=0x2.JSON";
        tokenURIs[
            3
        ] = "https://ipfs.io/ipfs/QmeNaZeDbeyMKaQbLAczmNJVATPVGZ2vyMTT2KRM19aBYB?filename=0x3.JSON";
        tokenURIs[
            4
        ] = "https://ipfs.io/ipfs/QmTC4BHDF6SpQPsgV98umRxkUYWRS2wUAKisdjY3bJ2QfN?filename=0x4.JSON";
        tokenURIs[
            5
        ] = "https://ipfs.io/ipfs/QmaBRthYaf5P8vnzRb7yBqUyJ32mbSM1X3y8aZ13vT2LAW?filename=0x5.JSON";
        tokenURIs[
            6
        ] = "https://ipfs.io/ipfs/QmZStJnqeMVSkiSPm1oqGe1QqLHEctTiJMcUPyToqtQiHn?filename=0x6.JSON";
        tokenURIs[
            7
        ] = "https://ipfs.io/ipfs/QmP2cYNjQr9pjcfZfLpnGeo1aCRpZNeuCeEAssHLTDAURC?filename=0x7.JSON";
        tokenURIs[
            8
        ] = "https://ipfs.io/ipfs/QmWvzWFLMH3gzf1eQEk3Q3PjNVH5aSTCV8dK6nAb19ecaN?filename=0x8.JSON";
        tokenURIs[
            9
        ] = "https://ipfs.io/ipfs/QmT8jnWGByzhs6ep4SFZXgLmgXYMi5HXqaRA5cVxwF98Rp?filename=0x9.JSON";
        s_URILength = 10; // s_URILength should equal totalSupply();
    }
}
