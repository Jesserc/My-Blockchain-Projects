// SPDX-License-Identifier: MIT;
pragma solidity >=0.7.0 <=0.8.15;

contract Test {


    mapping(address => uint256) balances;
  

    function deposit() public payable {
        require(msg.value > 0, "Input value");
        balances[msg.sender] += msg.value;
    }

    function contractBal() public view returns(uint256){
        return address(this).balance;
    }
    function returnBal() public view returns(uint256) {
        require(balances[msg.sender] > 0, "No amount deposited");
        return balances[msg.sender];
    }

    fallback() external {}

}
