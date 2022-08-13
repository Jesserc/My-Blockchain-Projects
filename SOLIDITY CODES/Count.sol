// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;
 uint constant NUM = 21;

contract Counter{

    uint public count;
    uint timer = 0;
    error timeNotReached(string);

    
     modifier requiredTime(){
          
            if(block.timestamp < timer){
                revert timeNotReached("Sorry wait till 30 seconds");
            }
            _;
           
        }

        function increment() public requiredTime {
            updateTime(block.timestamp + 30 seconds);
            count++;
          
        }

        function decrement() requiredTime public{
            count--;
            updateTime(block.timestamp + 30 seconds);
        }

        function updateTime(uint _timer) internal{
            timer = _timer;
        }

    
    function constantUP() public pure returns(uint){
        return NUM;
    }
} 