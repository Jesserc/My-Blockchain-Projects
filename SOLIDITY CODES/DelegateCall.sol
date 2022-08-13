// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestDelegateCall{
    //this contract is to test delegatecall in solidity
    //to do this, the storage layout in both contract must be same
    //delegate call, calls another contract but the storage of the calling 
    //contract is set instead while using the called contracts logic

    uint64 public num;
    address public caller;
    uint256 public value;

    //function to be called
    function setStateVars(uint64 _num) external payable{
        num = _num;
        caller = msg.sender;
        value = msg.value;
    }

  }


contract DelegateCall{
    //this is the contract performs the delegate call
    uint64 public num;
    address public caller;
    uint256 public value;

    //method one to perform delegate call
    function setStateVars(address addr, uint64 _num) external payable returns(bool success, bytes memory data){
       (success, data) = addr.delegatecall(abi.encodeWithSignature("setStateVars(uint64)",_num));
   
    }

      //method two to perform delegate call
    function setStateVarsTwo(address addr, uint64 _num) external payable returns(bool success, bytes memory data){ 
        (success, data) = addr.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setStateVars.selector,_num)
        );
    }

}