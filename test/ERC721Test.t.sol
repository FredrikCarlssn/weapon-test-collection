// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {WeaponTestCollection} from "../src/WeaponTestCollection.sol";
import {Vm} from "forge-std/Vm.sol";
import "forge-std/Test.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {TestCollectionStorage} from "../Config/TestCollectionStorage.sol";

contract NFTTest is Test {
    uint256 conter0 = 0;
    uint256 conter1 = 0;
    uint256 conter2 = 0;
    uint256 conter3 = 0;
    uint256 conter4 = 0;
    uint256 conter5 = 0;
    uint256 conter6 = 0;
    uint256 conter7 = 0;
    uint256 conter8 = 0;
    uint256 conter9 = 0;
    string constant DEFAULT_URI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8vUW1kWXJLNW9kSkVHSzJZRUVLWWNxNFZjUXFGaUd5WkVTNWhyUGRIWVNoUEJwRyIsICJuYW1lIjogIlN0b3JtYnJlYWtlciBTYWJlciIsICJkZXNjcmlwdGlvbiI6ICJORlQgVEVTVCBDT0xMRUNUSU9OIDB4MCIsICJhdHRyaWJ1dGVzIjogW3sidHJhaXRfdHlwZSI6ICJUeXBlIiwgInZhbHVlIjogIjFoIFN3b3JkIn0sIHsidHJhaXRfdHlwZSI6ICJUaWVyIiwgInZhbHVlIjogNH0sIHsidHJhaXRfdHlwZSI6ICJUaGVtZSIsICJ2YWx1ZSI6ICJQcmVjaXNpb24ifSwgeyJ0cmFpdF90eXBlIjogIkZhbWlseSIsICJ2YWx1ZSI6ICJQb3RlbmN5In0sIHsidHJhaXRfdHlwZSI6ICJEYW1hZ2UiLCAidmFsdWUiOiAyfSwgeyJ0cmFpdF90eXBlIjogIk1vZHNUeXBlIiwgInZhbHVlIjogIkNyaXRpY2FsIEhpdCBEYW1hZ2UifSwgeyJ0cmFpdF90eXBlIjogIk1vZHNWYWx1ZSIsICJ2YWx1ZSI6IDE1fSwgeyJ0cmFpdF90eXBlIjogIk1vZHNWYWx1ZTIiLCAidmFsdWUiOiAwfV19";
    WeaponTestCollection weaponTestCollection;

    function setUp() public {
        vm.prank(msg.sender);
        weaponTestCollection = new WeaponTestCollection();
        vm.prank(msg.sender);
        weaponTestCollection.mintNft(msg.sender, 0);
    }

    // WeaponTestCollection.sol Tests
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
        vm.prank(msg.sender);
        weaponTestCollection.mintMultipleNFTs(99);
        assertEq(weaponTestCollection.totalSupply(), 100);
    }

    function testInvalidMetadtaNumber() public {
        uint8 invalidMetaDataLength = (weaponTestCollection
            .getMetaDataLength() + 1);
        bytes4 selector = bytes4(keccak256("InvalidMetadataNumber(uint8)"));
        vm.prank(msg.sender);
        vm.expectRevert(
            abi.encodeWithSelector(selector, invalidMetaDataLength)
        );
        weaponTestCollection.mintNft(msg.sender, invalidMetaDataLength);
    }

    function testInvalidRecipient() public {
        bytes4 selector = bytes4(keccak256("InvalidAdress(address)"));
        vm.prank(msg.sender);
        vm.expectRevert(abi.encodeWithSelector(selector, address(0)));
        weaponTestCollection.mintNft(address(0), 0);
    }

    // TestCollectionStorage.sol Tests
    function testCreateMetadata() public {
        uint256 metaDataLengthShouldBe = (weaponTestCollection
            .getMetaDataLength() + 1);
        vm.prank(msg.sender);
        weaponTestCollection.createMetadata(
            "1h Sword",
            "Sword",
            "NFT TEST COLLECTION",
            "Weapon",
            1,
            "Crystal",
            "Crystal",
            15,
            1,
            1,
            1
        );
        assertEq(
            weaponTestCollection.getMetaDataLength(),
            metaDataLengthShouldBe
        );
    }

    function testCreateMod() public {
        uint256 modLengthShouldBe = (weaponTestCollection.getModLength() + 1);
        vm.prank(msg.sender);
        weaponTestCollection.createMod("Critical Hit Damage");
        assertEq(weaponTestCollection.getModLength(), modLengthShouldBe);
        string memory modShouldBe = weaponTestCollection.numberToModsType(
            weaponTestCollection.getModLength()
        );
        assertEq(modShouldBe, "Critical Hit Damage");
    }

    function testRandomNumber() public {
        for (uint i = 0; i < 1000; i++) {
            uint8 randomNumber = weaponTestCollection.getRandomNumber(9);
            if (randomNumber == 0) {
                conter0++;
            } else if (randomNumber == 1) {
                conter1++;
            } else if (randomNumber == 2) {
                conter2++;
            } else if (randomNumber == 3) {
                conter3++;
            } else if (randomNumber == 4) {
                conter4++;
            } else if (randomNumber == 5) {
                conter5++;
            } else if (randomNumber == 6) {
                conter6++;
            } else if (randomNumber == 7) {
                conter7++;
            } else if (randomNumber == 8) {
                conter8++;
            } else if (randomNumber == 9) {
                conter9++;
            }
        }
        console.log(conter0);
        console.log(conter1);
        console.log(conter2);
        console.log(conter3);
        console.log(conter4);
        console.log(conter5);
        console.log(conter6);
        console.log(conter7);
        console.log(conter8);
        console.log(conter9);
    }

    receive() external payable {}
}
