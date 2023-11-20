// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";

error InvalidMetadataNumber(uint8 _metaDataNumber);
error InvalidAdress(address _address);
error InvalidState(uint8 _state);
error nonExixtentToken(uint256 _tokenId);

contract WeaponTestCollection is
    ERC721,
    TestCollectionStorage,
    ReentrancyGuard
{
    uint256 private nonce = 0;
    uint24 private s_tokenCounter;
    string private s_baseURI =
        "data:application/json;base64,eyJpbWFnZSI6ICJpcGZzOi8v";

    mapping(uint256 => ItemImmutables) public tokenIdToItemImmutables;
    mapping(uint256 => ItemMutables) public tokenIdToItemMutables;

    event RerollLockedNft(uint256 tokenId);

    constructor() ERC721("NEW", "NWE") {
        defaultMint();
    }

    function mintNft(
        address _recipient,
        Item memory _item
    ) public nonReentrant onlyOwner {
        uint8 metaDataLenth = getMetaDataLength();
        if (_item.Immutables.ItemConstantsNumber > metaDataLenth)
            revert InvalidMetadataNumber(_item.Immutables.ItemConstantsNumber);
        if (_recipient == address(0)) revert InvalidAdress(_recipient);

        uint24 tokenId = s_tokenCounter++;

        tokenIdToItemImmutables[tokenId] = _item.Immutables;
        tokenIdToItemMutables[tokenId] = _item.Mutables;

        _safeMint(_recipient, tokenId);
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        if (ownerOf(_tokenId) == address(0)) revert nonExixtentToken(_tokenId);
        Item memory item = Item({
            Immutables: tokenIdToItemImmutables[_tokenId],
            Mutables: tokenIdToItemMutables[_tokenId]
        });
        return
            string(
                abi.encodePacked(
                    s_baseURI,
                    Base64.encode(constructAttributes(item))
                )
            );
    }

    function constructAttributes(
        Item memory _item
    ) internal view returns (bytes memory) {
        ItemConstants memory itemConstants = numberToDefaultMetaData[
            _item.Immutables.ItemConstantsNumber
        ];
        bytes memory part1 = abi.encodePacked(
            itemConstants.IMG,
            '", "Name": "',
            itemConstants.Name,
            '", "attributes": [{"trait_type": "Type", "value": "',
            itemConstants.Type,
            '"}, {"trait_type": "Class", "value": ',
            itemConstants.Class,
            '}, {"trait_type": "Loot Level", "value": "',
            Strings.toString(_item.Immutables.LootLevel),
            '"}, {"trait_type": "SeasonLooted", "value": "',
            numberToSeason[_item.Immutables.SeasonLooted],
            '"}, {"trait_type": "Rarity", "value": ',
            numberToRarity[_item.Immutables.Rarity]
        );
        bytes memory part2 = abi.encodePacked(
            '}, {"trait_type": "MinDamage", "value": "',
            Strings.toString(_item.Mutables.Mutables1.MinDamage),
            '"}, {"trait_type": "MaxDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MaxDamage),
            '}, {"trait_type": "MinPhysicalDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MinPhysicalDamage),
            '}, {"trait_type": "MaxPhysicalDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MaxPhysicalDamage),
            '}, {"trait_type": "MinLightningDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MinLightningDamage),
            '}, {"trait_type": "MaxLightningDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MaxLightningDamage),
            '}, {"trait_type": "MinAetherealDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MinAetherealDamage)
        );

        bytes memory part3 = abi.encodePacked(
            '}, {"trait_type": "MaxAetherealDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MaxAetherealDamage),
            '}, {"trait_type": "MinFireDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MinFireDamage),
            '}, {"trait_type": "MaxFireDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables1.MaxFireDamage),
            '}, {"trait_type": "MinColdDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinColdDamage),
            '}, {"trait_type": "MaxColdDamage", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MaxColdDamage),
            '}, {"trait_type": "AttackSpeed", "value": ',
            Strings.toString(_item.Mutables.Mutables2.AttackSpeed),
            '}, {"trait_type": "Range", "value": ',
            Strings.toString(_item.Mutables.Mutables2.Range)
        );
        bytes memory part4 = abi.encodePacked(
            '}, {"trait_type": "CriticalHitChance", "value": ',
            Strings.toString(_item.Mutables.Mutables2.CriticalHitChance),
            '}, {"trait_type": "MinCharacterLevel", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinCharacterLevel),
            '}, {"trait_type": "MinVitality", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinVitality),
            '}, {"trait_type": "MinCaliber", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinCaliber),
            '}, {"trait_type": "MinTrickery", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinTrickery),
            '}, {"trait_type": "MinBrilliance", "value": ',
            Strings.toString(_item.Mutables.Mutables2.MinBrilliance),
            '}, {"trait_type": "ModsType1", "value": ',
            numberToModsType[_item.Mutables.Mutables3.ModsType1]
        );
        bytes memory part5 = abi.encodePacked(
            '}, {"trait_type": "ModsValue1", "value": ',
            Strings.toString(_item.Mutables.Mutables3.ModsValue1),
            '}, {"trait_type": "ModsType2", "value": ',
            numberToModsType[_item.Mutables.Mutables3.ModsType2],
            '}, {"trait_type": "ModsValue2", "value": ',
            Strings.toString(_item.Mutables.Mutables3.ModsValue2),
            '}, {"trait_type": "ModsType3", "value": ',
            numberToModsType[_item.Mutables.Mutables3.ModsType3],
            '}, {"trait_type": "ModsValue3", "value": ',
            Strings.toString(_item.Mutables.Mutables3.ModsValue3),
            '}, {"trait_type": "ModsType4", "value": ',
            numberToModsType[_item.Mutables.Mutables3.ModsType4],
            '}, {"trait_type": "ModsValue4", "value": ',
            Strings.toString(_item.Mutables.Mutables3.ModsValue4),
            "}]}"
        );

        return (abi.encodePacked(part1, part2, part3, part4, part5));
    }

    // function getRandomNumber(uint8 max) public returns (uint8) {
    //     uint256 randomnumber = uint256(
    //         keccak256(
    //             abi.encodePacked(
    //                 msg.sender,
    //                 nonce,
    //                 block.timestamp,
    //                 block.number,
    //                 block.prevrandao
    //             )
    //         )
    //     ) % (max + 1);
    //     nonce++;
    //     return uint8(randomnumber);
    // }

    function defaultMint() public {
        mintNft(msg.sender, defaultItem);
    }

    function rerollNft(
        uint256 _tokenId,
        ItemMutables memory _itemMutables
    ) public onlyOwner {
        ItemMutables storage currentItem = tokenIdToItemMutables[_tokenId];
        if (currentItem.Mode == DynamicMode.Locked)
            revert InvalidState(uint8(DynamicMode.Locked));
        if (currentItem.Mode == DynamicMode.Rerolling) {
            currentItem.Mode = DynamicMode.Locked;
        }
        currentItem.Mutables1 = _itemMutables.Mutables1;
        currentItem.Mutables2 = _itemMutables.Mutables2;
        currentItem.Mutables3 = _itemMutables.Mutables3;
    }

    function rerollLockedNft(uint256 _tokenId) public {
        if (ownerOf(_tokenId) != msg.sender) revert InvalidAdress(msg.sender);
        tokenIdToItemMutables[_tokenId].Mode = DynamicMode.Rerolling;
        emit RerollLockedNft(_tokenId);
    }

    function lockNft(uint256 _tokenId) public {
        if (ownerOf(_tokenId) != msg.sender) revert InvalidAdress(msg.sender);
        tokenIdToItemMutables[_tokenId].Mode = DynamicMode.Locked;
    }

    function unlockNft(uint256 _tokenId) public {
        if (ownerOf(_tokenId) != msg.sender) revert InvalidAdress(msg.sender);
        tokenIdToItemMutables[_tokenId].Mode = DynamicMode.Unlocked;
    }

    function testReroll() public {
        rerollNft(0, rerollItemMutables);
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
