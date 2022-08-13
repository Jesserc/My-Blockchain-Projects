// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;

contract Pay{
// contarct address = 0x6056fee6109c49e1c0f07969c8c97f7453263548

    address public owner = payable(0x571B102323C3b8B8Afb30619Ac1d36d85359fb84);
  
  
    function withdraw() public {
    payable(owner).transfer(address(this).balance);
    }
    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    fallback() external payable{}
    receive() external payable{}
}