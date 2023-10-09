// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract WeaponTestCollection is ERC721, Ownable {
    constructor() ERC721("WeaponTestCollection", "WPNTST") Ownable() {}
}
