// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract FunctionOutputs{

    //function with named output can automatically return the values in the returns() 
    //statement without 
    //using the "return" keyword
		function FunctionWithNamedAssignedOutPut() public pure returns(uint u, bool b){
			u = 10;
			b = true;
	}	

		//destructing function outputs in solidity example
		function destructureOutput() public pure returns(uint _u, bool _b){
			//destructuring return value of the function below
			(uint u, bool b) = FunctionWithNamedAssignedOutPut();
			// (u, b) = (20, true);
			//assigning the values of the destructured function to new variables and 
			//returning them shorthand
			_u = u;
			_b = b;
		
		}

	
}