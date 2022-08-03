// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract FunctionOutputs {
    //function with named output can automatically return the values in the returns() statement
    // without using the "return" keyword
    function FunctionWithNamedAssignedOutPut()
        public
        pure
        returns (uint256 u, bool b)
    {
        u = 10;
        b = true;
    }

    //destructing function outputs in solidity example
    function destructureOutput() public pure returns (uint256 _u, bool _b) {
        //destructuring return value of the function below
        (uint256 u, bool b) = FunctionWithNamedAssignedOutPut();
        //assigning the values of the destructured function to new variables and
        //returning them shorthand
        _u = u; //10
        _b = b; //true
    }
}
