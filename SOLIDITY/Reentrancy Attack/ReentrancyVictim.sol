//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract ReentrancyVictim{

    mapping(address => uint) public balances;

    function deposit() external payable{
        // require(msg.value > 0 ether, "amount too low");
        balances[msg.sender] += msg.value;
    }

    function withdraw() external{                                                                                                            
        uint bal = balances[msg.sender];
        require(bal >= 0,"no balance for you");
        payable(msg.sender).transfer(bal);
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns(uint256 bal){
      bal = address(this).balance;
    }

}