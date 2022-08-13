// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Energy {
    /// State Variable

    uint constant totalSupply = 100000;
    uint public circulatingSupply;
    string constant name = "Energy";
    string constant symbol = "ENG";
    uint constant decimal = 1e18;
    address owner;

    mapping(address => uint) public _balance;

    event TokenMint(address indexed _to, uint _amount);
    event Transfer(address indexed from, address indexed _to, uint amount);

    modifier onlyOwner() {
        require(owner == msg.sender, "no permission!");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function _name() public pure returns(string memory) {
        return name;
    }

    function _symbol() public pure returns(string memory) {
        return symbol;
    }

    function _decimal() public pure returns(uint) {
        return decimal;
    }

    function _totalSupply() public pure returns(uint) {
        return totalSupply;
    }

    function mint(uint amount, address _to) public onlyOwner returns(uint) {
        circulatingSupply += amount; // increase total circulating supply
        require(circulatingSupply <= totalSupply, "total Supply Exceeded!");
        require(_to != address(0), "mint to address zero");
        uint value = amount * decimal;
        _balance[_to] += value; // increase balance of to
        emit TokenMint(_to, value);
        return value;
    }

    function transfer(address _to, uint amount) external {
        require(_to != address(0), "transfer to address zero");
        uint userBalance = _balance[msg.sender];
        require(userBalance >= amount, "Insufficient funds");

        uint burnableToken = _burn(amount);
        uint transferrable = amount - burnableToken;

        require(_to != msg.sender, "You need to send to another user!");
        _balance[msg.sender] -= amount;
        _balance[_to] += transferrable;

        emit Transfer(msg.sender, _to, amount);
    }

    function _burn(uint amount) private returns(uint256 burnableToken) {
        burnableToken = calculateBurn(amount);
        circulatingSupply -= burnableToken / decimal;
    }

    function calculateBurn(uint amount) public pure returns(uint burn) {
        burn = (amount * 10)/100;
    }

    function balanceOf(address who) public view returns(uint) {
        return _balance[who];
    }

    ////////////////////////////////////////////////////////////////////
    mapping(address => mapping(address => uint)) _allowance;

    modifier checkBalance(address _owner, uint amount) {
        uint balance = balanceOf(_owner);
        require(balance >= amount, "insufficient fund!");
        _;

    }

    function Approve(address spender, uint amount) external checkBalance(msg.sender, amount) {
        require(spender != address(0));
        _allowance[msg.sender][spender] += amount;
    }

    function transferFrom(address from, address _to, uint amount) external checkBalance(from, amount) {
        require(_to == msg.sender, "not spender");
        uint _allowanceBalance = _allowance[from][_to];
        require(_allowanceBalance >= amount, "sorry, no allowance for you!");
        
        _allowance[from][_to] -= amount;
        require(_balance[from] >= amount, "not enough money!");
        uint burnableToken = _burn(amount);
        uint transferrable = amount - burnableToken;

        _balance[from] -= amount;
        _balance[_to] += transferrable;
    }

}
