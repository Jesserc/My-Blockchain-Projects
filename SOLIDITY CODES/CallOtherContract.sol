//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Parent{
uint public x;

    function setX(uint _x) public{
        x=_x;
    }

}
contract Child{
uint public x;
function callX(Parent parent, uint _x) public {
    //this updates the x state variable in "Parent" contract above and not it's own x var
    parent.setX(_x);
}

}