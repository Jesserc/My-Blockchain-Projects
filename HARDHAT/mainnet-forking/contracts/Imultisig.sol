//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

interface Imultisig {
    function withdrawEther(uint256 _amount) external;

    function Approve(uint256 id) external;

    function contractBalance() external view returns (uint256);

    function validOwner() external view returns (bool success);
}
