// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//compiler version, requers diffrent
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
    WeaponTestCollection weaponTestCollection;  //

    function setUp() public {
        vm.prank(msg.sender);
        weaponTestCollection = new WeaponTestCollection();
    }

    function testMultipleMint() public {
        for (uint256 i = 0; i < 100; i++) {
            vm.prank(msg.sender);
            weaponTestCollection.defaultMint();
            console.log("hello");
        }
    }

    ////// WeaponTestCollection.sol Tests
    function testUri() public {
        string memory uri = weaponTestCollection.tokenURI(0);
        assertEq(uri, DEFAULT_URI);
    }

    function testMint() public {
        vm.prank(msg.sender);

        // Skapa en Item-instans
        TestCollectionStorage.Item memory item = TestCollectionStorage.Item({
            Immutables: TestCollectionStorage.ItemImmutables({
                ItemConstantsNumber: 0,
                LootLevel: 55,
                SeasonLooted: 0,
                Rarity: 2
            }),
            Mutables: TestCollectionStorage.ItemMutables({
                    Mutables1: TestCollectionStorage.ItemMutables1({
                    MinDamage: 30,
                    MaxDamage: 80,
                    MinPhysicalDamage: 30,
                    MaxPhysicalDamage: 80,
                    MinLightningDamage: 0,
                    MaxLightningDamage: 0,
                    MinAetherealDamage: 0,
                    MaxAetherealDamage: 0,
                    MinFireDamage: 0,
                    MaxFireDamage: 0
                }),
                Mutables2: TestCollectionStorage.ItemMutables2({
                    MinColdDamage: 0,
                    MaxColdDamage: 0,
                    AttackSpeed: 23,
                    Range: 25,
                    CriticalHitChance: 10,
                    MinCharacterLevel: 5,
                    MinVitality: 0,
                    MinCaliber: 0,
                    MinTrickery: 0,
                    MinBrilliance: 0
                }),
                Mutables3: TestCollectionStorage.ItemMutables3({
                    ModsType1: 10, 
                    ModsValue1: 25,
                    ModsType2: 11, 
                    ModsValue2: 70,
                    ModsType3: 7, 
                    ModsValue3: 6,
                    ModsType4: 9, 
                    ModsValue4: 25
                }),
                Mode: TestCollectionStorage.DynamicMode.Unlocked
            })
        });

        weaponTestCollection.mintNft(msg.sender, item);

        uint256 supply = weaponTestCollection.totalSupply();
        assertEq(supply, 2);
    } //

    /* function testBatchMint() public {
        vm.prank(msg.sender);
        weaponTestCollection.mintMultipleNFTs(99);
        assertEq(weaponTestCollection.totalSupply(), 100);
    } */ //Behövs inte, då ej mintMultipleNFT

    function testOwner() public {
        address shouldBeSender = weaponTestCollection.ownerOf(0);
        assertEq(shouldBeSender, msg.sender);
    }

    function testInvalidMetadtaNumber() public {
        uint8 invalidMetaDataLength = (weaponTestCollection
            .getMetaDataLength() + 1);
        bytes4 selector = bytes4(keccak256("InvalidMetadataNumber(uint8)"));
        vm.prank(msg.sender);
        vm.expectRevert(  //expectRevert Vm.sol men har senaste std (npm install forge-std@latest) och latest solc compiler... settings solidity complier version Compiler
        //( using remote version: 'latest', solidity version: 0.8.19+commit.7dd6d404.Emscripten.clang)
            abi.encodeWithSelector(selector, invalidMetaDataLength),
            "WeaponTestCollection: InvalidMetadataNumber"
        );
        weaponTestCollection.mintNft(msg.sender, invalidMetaDataLength);
    } 

    function testInvalidAddress() public {
        address invalidAddress = address(0);
        bytes4 selector = bytes4(keccak256("InvalidAdress(address)"));
        vm.prank(msg.sender);
        vm.expectRevert(
            abi.encodeWithSelector(selector, invalidAddress),
            "WeaponTestCollection: InvalidAdress"
        ); //
    }

   /*  function testInvalidRecipient() public {
       bytes4 selector = bytes4(keccak256("InvalidAdress(address)"));
       vm.prank(msg.sender);
        vm.expectRevert(abi.encodeWithSelector(selector, address(0)));
        weaponTestCollection.mintNft(address(0), 0);
    } */ //Testar som ovan, ogiltiga adresser 

    function testNonexistentToken() public {
        uint256 nonexistentTokenId = 999;
        bytes4 selector = bytes4(keccak256("nonExixtentToken(uint256)"));
        vm.prank(msg.sender);
        vm.expectRevert(
            abi.encodeWithSelector(selector, nonexistentTokenId),
            "WeaponTestCollection: nonExixtentToken"
        );
    } //

    function testLockedReroll() public {
        uint256 tokenId = 0;
        weaponTestCollection.lockNft(tokenId);
        bytes4 selector = bytes4(keccak256("rerollLockedNft(uint256)"));
        vm.prank(msg.sender);
        vm.expectRevert(
            abi.encodeWithSelector(selector, tokenId),
            "WeaponTestCollection: InvalidState"
        );
    } //

    function testRerollWhileRerolling() public {
        uint256 tokenId = 0;
        weaponTestCollection.rerollLockedNft(tokenId);
        bytes4 selector = bytes4(keccak256("rerollLockedNft(uint256)"));
        vm.prank(msg.sender);
        vm.expectRevert(
            abi.encodeWithSelector(selector, tokenId),
            "WeaponTestCollection: InvalidState"
        );
    } //

    function testReroll() public {
        uint256 tokenId = 0;
        weaponTestCollection.rerollNft(tokenId, weaponTestCollection.rerollItemMutables);
        assertEq(
            weaponTestCollection.tokenIdToItemMutables(tokenId).Mode,
            uint8(TestCollectionStorage.DynamicMode.Locked)
        );
    } //

    ////// TestCollectionStorage.sol Tests
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

    function testCreateSeason() public {
        weaponTestCollection.createSeason("test");
        uint8 seasonLength = weaponTestCollection.getSeasonLength();
        assertEq(seasonLength, 1);
    } //

    function testCreateRarity() public {
        weaponTestCollection.createRarity("test");
        uint8 rarityLength = weaponTestCollection.getRarityLength(); 
        assertEq(rarityLength, 4);
    } //

    function testDefaultItem() public {
        assertEq(
            weaponTestCollection.defaultItem.Immutables.ItemConstantsNumber,
            uint8(0)
        );
    } //

    function testConstructAttributes() public {
        WeaponTestCollection.Item memory item = weaponTestCollection
            .tokenIdToItemImmutables(0);
        bytes memory attributes = weaponTestCollection
            .constructAttributes(item);
        assertEq(abi.decode(attributes, (uint256)), 115);
    } //

    function testGetMetaDataLength() public {
        uint8 metaDataLength = weaponTestCollection.getMetaDataLength();
        assertEq(metaDataLength, 1);
    } //

    function testGetModLength() public {
        uint8 modLength = weaponTestCollection.getModLength();
        assertEq(modLength, 11);
    }

    function testGetSeasonLength() public {
        uint8 seasonLength = weaponTestCollection.getSeasonLength();
        assertEq(seasonLength, 1);
    } //

    function testRarityLength() public {
        uint8 rarityLength = weaponTestCollection.getRarityLength(); 
        assertEq(rarityLength, 4);
    } //
}

    // function testRandomNumber() public {
    //     for (uint i = 0; i < 1000; i++) {
    //         uint8 randomNumber = weaponTestCollection.getRandomNumber(9);
    //         if (randomNumber == 0) {
    //             conter0++;
    //         } else if (randomNumber == 1) {
    //             conter1++;
    //         } else if (randomNumber == 2) {
    //             conter2++;
    //         } else if (randomNumber == 3) {
    //             conter3++;
    //         } else if (randomNumber == 4) {
    //             conter4++;
    //         } else if (randomNumber == 5) {
    //             conter5++;
    //         } else if (randomNumber == 6) {
    //             conter6++;
    //         } else if (randomNumber == 7) {
    //             conter7++;
    //         } else if (randomNumber == 8) {
    //             conter8++;
    //         } else if (randomNumber == 9) {
    //             conter9++;
    //         }
    //     }
    //     console.log(conter0);
    //     console.log(conter1);
    //     console.log(conter2);
    //     console.log(conter3);
    //     console.log(conter4);
    //     console.log(conter5);
    //     console.log(conter6);
    //     console.log(conter7);
    //     console.log(conter8);
    //     console.log(conter9);
    // }

/*     receive() external payable {}
}
 */
