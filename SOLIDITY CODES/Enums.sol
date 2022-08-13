// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;

contract Enum{
    enum Status{
        Done,
        AlmostDone,
        Failed
    }

    Status public status =  Status.AlmostDone;
     
    function setStatus() public{
    status = Status.Failed;
   }

   function set(Status _index) external returns(Status){
      return status = _index;
   }

    function reset() external{
        delete status;
    }

}