// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {ERC1967Proxy} from "@openzeppelin-contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract UpgradeBoxScript is Script {
    function setUp() public {}

    function run() external returns (address proxy) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
    }
    function upgradeBox(
        address _proxyAddress,
        address _newImplAddress
    ) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(_proxyAddress);
        proxy.upgradeToAndCall(_newImplAddress, "");
        vm.stopBroadcast();
        return _proxyAddress;
    }
}
