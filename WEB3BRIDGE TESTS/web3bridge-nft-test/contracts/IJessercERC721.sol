// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IJesserc {
    function safeMint(address to, string memory uri) external;

    function balanceOf(address owner) external view returns (uint256 balance);
}
