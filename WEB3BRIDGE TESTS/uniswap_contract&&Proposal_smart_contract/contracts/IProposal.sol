// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IProposal {
    function createProposal(string memory _title, uint256 _deadline) external;

    function returnProposal(uint256 _id)
        external
        view
        returns (
            string memory,
            address,
            uint256,
            uint256,
            bool
        );
}
