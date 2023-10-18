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
        weaponTestCollection.mintNft(msg.sender, 0);
    }

    function testUri() public {
        string memory uri = weaponTestCollection.tokenURI(0);
        console.log(uri);
        assertEq(uri, DEFAULT_URI);
    }

    function testMint() public {
        weaponTestCollection.mintNft(msg.sender, 0);
        uint256 supply = weaponTestCollection.totalSupply();
        assertEq(supply, 2);
    }

    function testOwner() public {
        address shouldBeSender = weaponTestCollection.ownerOf(0);
        assertEq(shouldBeSender, msg.sender);
    }

    function testBatchMint() public {
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        weaponTestCollection.mintNft(msg.sender, 0);
        assertEq(weaponTestCollection.totalSupply(), 100);
    }

    // function testFailMintNoPaid() public {
    //     weaponTestCollection.mintNft(msg.sender, DEFAULT_URI, 0);
    //     vm.expectRevert("wrongpayment()");
    // }

    // function testCorrectMintPrice() public {
    //     weaponTestCollection.mintNft(msg.sender, DEFAULT_URI, 0);
    // }

    // function testMintAndSuppply() public {
    //     weaponTestCollection.mintNft(msg.sender, DEFAULT_URI, 0);
    //     weaponTestCollection.mintNft(msg.sender, DEFAULT_URI, 0);
    //     uint256 supply = weaponTestCollection.totalSupply();
    //     assertEq(supply, 12);
    // }

    // function testFailMintToZeroAddress() public {
    //     address zero = address(0);
    //     hoax(zero, 2 ether);
    //     weaponTestCollection.mintNft{value: 1 ether}(zero, DEFAULT_URI, 0);
    //     vm.expectRevert("ERC721: mint to the zero address");
    // }

    // function testFailUnSafeContractReceiver() public {
    //     vm.etch(address(1), bytes("mock code"));
    //     vm.prank(address(1));
    //     weaponTestCollection.mintNft{value: 1 ether}(
    //         msg.sender,
    //         DEFAULT_URI,
    //         0
    //     );
    // }

    // function testreveal() public {
    //     address bob = vm.addr(8);
    //     hoax(bob, 2 ether);
    //     weaponTestCollection.mintNft{value: 1 ether}(bob, DEFAULT_URI, 0);
    //     string memory meta = DEFAULT_URI;
    //     string memory uri = weaponTestCollection.uri(0);
    //     console.log("URI1: ", weaponTestCollection.uri(0));
    //     assertEq(uri, meta);
    // }

    // function testFailMetadataQuery() public {
    //     address bob = vm.addr(6);
    //     startHoax(bob, 2 ether);
    //     weaponTestCollection.uri(1);
    //     vm.expectRevert("nonexistenttoken()");
    // }

    // function bytes32ToString(
    //     bytes32 _bytes32
    // ) public pure returns (string memory) {
    //     uint8 i = 0;
    //     while (i < 32 && _bytes32[i] != 0) {
    //         i++;
    //     }
    //     bytes memory bytesArray = new bytes(i);
    //     for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
    //         bytesArray[i] = _bytes32[i];
    //     }
    //     return string(bytesArray);
    // }

    receive() external payable {}
}
