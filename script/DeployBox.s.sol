// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";

import {ERC1967Proxy} from "@openzeppelin-contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBoxV1Script is Script {
    BoxV1 public box;

    function setUp() public {}

    function run() external returns (address) {
        vm.startBroadcast();

        box = new BoxV1(); // Implementation
        bytes memory data = abi.encodeWithSelector(
            box.initialize.selector,
            address(this)
        );
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), data);

        vm.stopBroadcast();

        return address(proxy);
    }
}
