// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {TestCollectionStorage} from "Config/TestCollectionStorage.sol";
import {JsonWriter} from "@solidity-json-writer/contracts/JsonWriter.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract WeaponTestCollection is ERC721, TestCollectionStorage {
    using JsonWriter for JsonWriter.Json;

    uint256 private s_tokenCounter = 0;
    string private s_baseURI = "data:application/json;base64,";

    mapping(uint256 => Item) public tokenIdToItem;
    mapping(uint256 tokenId => address) private owners;

    constructor() ERC721("NEW", "NWE") {
        // mintNft(msg.sender, 0);
    }

    function mintNft(address _recipient, uint256 _metaDataNumber) public {
        _safeMint(_recipient, s_tokenCounter);
        tokenIdToItem[s_tokenCounter] = s_tokenMetaDataArray[_metaDataNumber];
        owners[s_tokenCounter] = _recipient;
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        JsonWriter.Json memory writer;
        Item memory tokenItem = tokenIdToItem[_tokenId];

        writer.writeStartObject();
        writer.writeStringProperty("name", tokenItem.Name);
        writer.writeStringProperty("description", tokenItem.Description);
        writer.writeStringProperty("image", tokenItem.IMG);
        writer.writeStartArray("attributes");
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "Type");
        writer.writeStringProperty("value", tokenItem.Type);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "Tier");
        writer.writeUintProperty("value", tokenItem.Tier);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "Theme");
        writer.writeStringProperty("value", tokenItem.Theme);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "Family");
        writer.writeStringProperty("value", tokenItem.Family);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "Damage");
        writer.writeUintProperty("value", tokenItem.Damage);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "ModsType");
        writer.writeStringProperty("value", tokenItem.ModsType);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "ModsValue");
        writer.writeUintProperty("value", tokenItem.ModsValue);
        writer.writeEndObject();
        writer.writeStartObject();
        writer.writeStringProperty("trait_type", "ModsValue2");
        writer.writeUintProperty("value", tokenItem.ModsValue2);
        writer.writeEndObject();
        writer.writeEndArray();
        writer.writeEndObject();

        return
            string(
                abi.encodePacked(
                    s_baseURI,
                    Base64.encode(bytes(abi.encodePacked(writer.value)))
                )
            );
    }

    function totalSupply() public view returns (uint256) {
        return s_tokenCounter;
    }
}
