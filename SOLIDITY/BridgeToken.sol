// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Bridge is ERC20{

address owner;

    modifier onlyOnwer(){
    require(msg.sender == owner,"Not owner");
    _;
 }

    constructor() ERC20("Jesserc", unicode"⛓") {
        owner = msg.sender;
        _mint(address(this), 10000 * 10 ** decimals());
    }



    function sendTokenExternal( address to, uint256 amount) public onlyOnwer{
        require(to != address(0), "ERC: not a valid address");
        uint currentBal = balanceOf(address(this));
        require(currentBal >= amount,"Sorry, insufficient balance");
        _transfer(address(this),to, amount);
    }
}