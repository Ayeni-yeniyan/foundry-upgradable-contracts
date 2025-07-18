// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract BoxV1 {
    uint256 internal number;

    function getVersion() external pure returns (uint256) {
        return 1;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }
}
