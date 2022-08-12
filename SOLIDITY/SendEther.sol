// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SendEther{
 

 constructor()payable{}

 function Transfer(address payable to) public {
     to.transfer(123);

 } 

 function Send(address payable to) public {
   bool sent = to.send(123);
   require(sent, "not sent");

 }
  
 function Call(address payable to) public  returns(bool){
   (bool status,) = to.call{value:123, gas: 300}("");
    require(status, "send failure");
    return status;
 }

 fallback() external payable{}
 receive() external payable{}

}

contract receiveEther{
    event Got(uint value, address sender, uint gas);


   receive() external payable{
       emit Got(msg.value, msg.sender, gasleft());

   }
}