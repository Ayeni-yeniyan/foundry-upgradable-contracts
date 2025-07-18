// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
// import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {UpgradeBoxScript} from "../script/UpgradeBox.s.sol";
import {DeployBoxV1Script} from "../script/DeployBox.s.sol";

contract DeployAndUpgrade is Test {
    address public proxy;
    BoxV2 public newBox;
    DeployBoxV1Script public deployer;
    UpgradeBoxScript public upgradeDeployer;
    address owner = makeAddr("OWNER");

    function setUp() public {
        deployer = new DeployBoxV1Script();
        upgradeDeployer = new UpgradeBoxScript();
        proxy = deployer.run();
    }

    function test_StartsAsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(5);
    }

    function test_Upgrades() public {
        BoxV2 boxV2 = new BoxV2();
        upgradeDeployer.upgradeBox(proxy, address(boxV2));
        uint256 expectedVersion = 2;
        assertEq(expectedVersion, BoxV2(proxy).getVersion());
        BoxV2(proxy).setNumber(7);

        assertEq(7, BoxV2(proxy).getNumber());
    }
}
