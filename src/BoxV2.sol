// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract BoxV2 {
    uint256 internal number;

    function setNumber(uint256 _number) external returns (uint256) {
        return number = _number;
    }
    function getVersion() external pure returns (uint256) {
        return 2;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }
}
