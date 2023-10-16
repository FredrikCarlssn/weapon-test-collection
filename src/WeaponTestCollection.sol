// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155URIStorage} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";
import {JsonWriter} from "@solidity-json-writer/contracts/JsonWriter.sol";

contract WeaponTestCollection is ERC1155, TestCollectionStorage {
    using JsonWriter for JsonWriter.Json;

    uint256 private s_tokenCounter = 0;
    string private s_baseURI = "data:application/json,";

    mapping(uint256 => Item) public tokenIdToItem;
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    mapping(address => mapping(address => bool)) internal operatorApproval;

    constructor() ERC1155("") {}

    function mintNft(address _recipient, uint256 _metaDataNumber) public {
        _mint(_recipient, s_tokenCounter, 0, "");
        _setURI(s_tokenCounter, s_tokenMetaDataArray[_metaDataNumber]);
        _balances[s_tokenCounter][_recipient] = 1;
        s_tokenCounter++;
    }

    function uri(
        uint256 _tokenId
    ) public view override returns (string memory) {
        JsonWriter.Json memory writer;
        Item memory tokenItem = tokenIdToItem[_tokenId];

        writer.writeStartObject();
        writer.writeStringProperty("Name", tokenItem.Name);
        writer.writeStringProperty("Description", tokenItem.Description);
        writer.writeStartArray("attributes");
        writer.writeStringProperty("image", tokenItem.IMG);
        writer.writeStringProperty("Type", tokenItem.Type);
        writer.writeUintProperty("Tier", tokenItem.Tier);
        writer.writeStringProperty("Theme", tokenItem.Theme);
        writer.writeStringProperty("Family", tokenItem.Family);
        writer.writeUintProperty("Damage", tokenItem.Damage);
        writer.writeStringProperty("ModsType", tokenItem.ModsType);
        writer.writeUintProperty("ModsValue", tokenItem.ModsValue);
        writer.writeUintProperty("ModsValue2", tokenItem.ModsValue2);
        writer.writeEndObject();

        return
            bytes(writer.value).length > 0
                ? string.concat(s_baseURI, writer.value)
                : super.uri(_tokenId);
    }

    function _setURI(uint256 _tokenId, Item storage _tokenMetaData) internal {
        tokenIdToItem[_tokenId] = _tokenMetaData;
    }

    function balanceOf(
        address account,
        uint256 id
    ) public view override returns (uint256) {
        return _balances[id][account];
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
