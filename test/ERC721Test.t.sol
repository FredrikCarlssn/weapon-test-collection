// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {WeaponTestCollection} from "../src/WeaponTestCollection.sol";
import {Vm} from "forge-std/Vm.sol";
import "forge-std/Test.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTTest is Test {
    string constant DEFAULT_URI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8vUW1kWXJLNW9kSkVHSzJZRUVLWWNxNFZjUXFGaUd5WkVTNWhyUGRIWVNoUEJwRyIsICJuYW1lIjogIlN0b3JtYnJlYWtlciBTYWJlciIsICJkZXNjcmlwdGlvbiI6ICJORlQgVEVTVCBDT0xMRUNUSU9OIDB4MCIsICJhdHRyaWJ1dGVzIjogW3sidHJhaXRfdHlwZSI6ICJUeXBlIiwgInZhbHVlIjogIjFoIFN3b3JkIn0sIHsidHJhaXRfdHlwZSI6ICJUaWVyIiwgInZhbHVlIjogNH0sIHsidHJhaXRfdHlwZSI6ICJUaGVtZSIsICJ2YWx1ZSI6ICJQcmVjaXNpb24ifSwgeyJ0cmFpdF90eXBlIjogIkZhbWlseSIsICJ2YWx1ZSI6ICJQb3RlbmN5In0sIHsidHJhaXRfdHlwZSI6ICJEYW1hZ2UiLCAidmFsdWUiOiAyfSwgeyJ0cmFpdF90eXBlIjogIk1vZHNUeXBlIiwgInZhbHVlIjogIkNyaXRpY2FsIEhpdCBEYW1hZ2UifSwgeyJ0cmFpdF90eXBlIjogIk1vZHNWYWx1ZSIsICJ2YWx1ZSI6IDE1fSwgeyJ0cmFpdF90eXBlIjogIk1vZHNWYWx1ZTIiLCAidmFsdWUiOiAwfV19";
    WeaponTestCollection weaponTestCollection;

    function setUp() public {
        vm.prank(msg.sender);
        weaponTestCollection = new WeaponTestCollection();
        vm.prank(msg.sender);
        weaponTestCollection.mintNft(msg.sender, 0);
    }

    function testUri() public {
        string memory uri = weaponTestCollection.tokenURI(0);
        assertEq(uri, DEFAULT_URI);
    }

    function testMint() public {
        vm.prank(msg.sender);
        weaponTestCollection.mintNft(msg.sender, 0);
        uint256 supply = weaponTestCollection.totalSupply();
        assertEq(supply, 2);
    }

    function testOwner() public {
        address shouldBeSender = weaponTestCollection.ownerOf(0);
        assertEq(shouldBeSender, msg.sender);
    }

    function testBatchMint() public {
        for (uint256 i = 0; i < 99; i++) {
            vm.prank(msg.sender);
            weaponTestCollection.mintNft(msg.sender, 0);
        }
        assertEq(weaponTestCollection.totalSupply(), 100);
    }

    receive() external payable {}
}
