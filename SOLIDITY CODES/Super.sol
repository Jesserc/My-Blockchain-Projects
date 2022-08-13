// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A{

    event Log(string);
    function foo() public virtual{
        emit Log("A.foo");
    }

}

contract B is A{

    function foo() public virtual override{
        emit Log("B.foo");
        super.foo();
    }

}

contract C is A, B{

    function foo() public virtual override(A,B){
       super.foo();
    }

}



