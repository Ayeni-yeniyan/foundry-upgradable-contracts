// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {UUPSUpgradeable} from "@openzeppelin/upgradables/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/upgradables/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/upgradables/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }
    function getVersion() external pure returns (uint256) {
        return 1;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
