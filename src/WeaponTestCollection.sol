// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155URIStorage} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";
import {JsonWriter} from "@solidity-json-writer/contracts/JsonWriter.sol";

contract WeaponTestCollection is ERC1155URIStorage, TestCollectionStorage {
    using JsonWriter for JsonWriter.Json;

    uint256 private s_tokenCounter = 0;
    mapping(uint256 => Item) public tokenIdToItem;

    constructor() ERC1155("") {
        _setBaseURI("data:application/json,");
    }

    function mintNft(
        address _recipient,
        uint256 _metaDataNumber
    ) public payable {
        _mint(_recipient, s_tokenCounter, 0, "");
        _setURI(s_tokenCounter, s_tokenMetaDataArray[_metaDataNumber]);
        s_tokenCounter++;
    }

    function uri(
        uint256 _tokenId
    ) public view override returns (string memory) {
        JsonWriter.Json memory writer;
        Item memory tokenItem = tokenIdToItem[_tokenId];

        writer.writeStartObject();
        writer.writeStringProperty("IMG", tokenItem.IMG);
        writer.writeStringProperty("Name", tokenItem.Name);
        writer.writeStringProperty("Description", tokenItem.Description);
        writer.writeStringProperty("Type", tokenItem.Type);
        writer.writeUintProperty("Tier", tokenItem.Tier);
        writer.writeStringProperty("Theme", tokenItem.Theme);
        writer.writeStringProperty("Family", tokenItem.Family);
        writer.writeUintProperty("Damage", tokenItem.Damage);
        writer.writeStringProperty("ModsType", tokenItem.ModsType);
        writer.writeUintProperty("ModsValue", tokenItem.ModsValue);
        writer.writeUintProperty("ModsValue2", tokenItem.ModsValue2);
        writer.writeEndObject();
        writer.writeEndObject();

        return writer.value;
    }

    function _setURI(uint256 _tokenId, Item storage _tokenMetaData) internal {
        tokenIdToItem[_tokenId] = _tokenMetaData;
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
