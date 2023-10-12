// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TestCollectionStorage {
    mapping(uint256 => string) public tokenURIs;
    uint256 internal s_URILength;

    constructor() {
        tokenURIs[
            0
        ] = "https://ipfs.io/ipfs/Qmf6NetjT2Pz4U8qFXQTSWVfmthkHGDdx1gp3ZUrDBmp1j?filename=0.JSON";
        tokenURIs[
            1
        ] = "https://ipfs.io/ipfs/QmPYwdLj7mC1AzCiH9hYoxHRAUbrVNar8rxZ495dWbWwpr?filename=1.JSON";
        tokenURIs[
            2
        ] = "https://ipfs.io/ipfs/QmVPtMNRFo3hJMGKmhxVwJfaGX7USmnVzRqiuzTUEFnhVs?filename=2.JSON";
        tokenURIs[
            3
        ] = "https://ipfs.io/ipfs/QmTmyD2Yvo4m8Y3KPHwK26wQBhG6qJ8LmTB139hZ2wGaJE?filename=3.JSON";
        tokenURIs[
            4
        ] = "https://ipfs.io/ipfs/QmWLBVdKFrrgg2KLFfN8qstiif5ZJqhSKk8CQ1BUw8H1Qy?filename=4.JSON";
        tokenURIs[
            5
        ] = "https://ipfs.io/ipfs/QmQMiAKwqDeiwEB8Qk5MiZYkjsD349QmdisYYHLSA3xpjD?filename=5.JSON";
        tokenURIs[
            6
        ] = "https://ipfs.io/ipfs/QmS9jyCnFaGYAwYKkEGkEexJc8Fuqt3epajZ9a5ZZdRzvu?filename=6.JSON";
        tokenURIs[
            7
        ] = "https://ipfs.io/ipfs/QmP9Lei1DV2ciuGr9GmZftdn5wdrDzwF1p5JWy1J8GHrzM?filename=7.JSON";
        tokenURIs[
            8
        ] = "https://ipfs.io/ipfs/Qme1UCpiewT5mWzDcZKTcxkgWG4QRzPcAkHfzT76TXe7Fg?filename=8.JSON";
        tokenURIs[
            9
        ] = "https://ipfs.io/ipfs/QmdNZL3zUcwM5w72LudjRjBz2iQb7hZpphJVEGqf42HUWE?filename=9.JSON";
        s_URILength = 10; // s_URILength should equal totalSupply();
    }
}
