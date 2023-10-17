// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {WeaponTestCollection} from "src/WeaponTestCollection.sol";

contract DeployTestCollection is Script {
    function run() public returns (WeaponTestCollection) {
        vm.startBroadcast();
        WeaponTestCollection weaponTestCollection = new WeaponTestCollection();
        vm.stopBroadcast();
        return weaponTestCollection;
    }
}
