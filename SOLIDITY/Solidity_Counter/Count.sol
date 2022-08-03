// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
@title Counter Contract
 @author Jesse Raymond
 @notice  This is a simple counter contract, where users can increment and decrement the value of the variable count(see below), once every 30 seconds.
 @dev Key concepts in solidity i used: 
 - Modifier, 
 - Internal function,
 - Custom error.
 ---Variables Declared:
 - count(the value to be incremented and decremented),
 - timer(variable holding the 30 seconds limit)
 - timeNotReached(custom error)
 - increment and decrement functions.
 */
contract Counter {
    // public variable to store number of counts
    uint256 public count;
    // variable for 30 seconds timer - first initialized as 0 and is updated by internal function updateTime();
    uint256 timer = 0;
    // custom error to save gas(used in modifier below)
    error timeNotReached(string);

    // this modifier check if the 30 seconds timer has reached, if not, it restricts user from calling the increment or decrement function
    modifier requiredTime() {
        if (block.timestamp < timer) {
            revert timeNotReached("Sorry wait till 30 seconds");
        }
        _;
    }

    // function to increment value of the count
    function increment() public requiredTime {
        updateTime(block.timestamp + 30 seconds);
        count++;
    }

    // function to decrement value of the count
    function decrement() public requiredTime {
        count--;
        updateTime(block.timestamp + 30 seconds);
    }

    //internal function to update timer
    function updateTime(uint256 _timer) internal {
        timer = _timer;
    }
}
