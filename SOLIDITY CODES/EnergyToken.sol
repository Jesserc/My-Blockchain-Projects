// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Energy {
    //have total supply
    //transferrable
    //name
    //symbol
    //decimal
    //user balance
    //burnable

    ///State Variables //////

    uint256 constant totalSupply = 10000;
    uint256 public circulatingSupply;
    string constant name = "Energy";
    string constant symbol = "ENG";
    uint256 constant decimal = 1e18;
    address owner;

    mapping(address => uint256) public _balance;
    mapping(address => mapping(address => uint256)) _allowance;


    event tokenMint(address indexed _to, uint256 indexed _amount);
    event _transfer(address from, address _to, uint256 amount);
    modifier onlyOwner() {
        require(owner == msg.sender, "No permission");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function _name() public pure returns (string memory) {
        return name;
    }

    function _symbol() public pure returns (string memory) {
        return symbol;
    }

    function _decimal() public pure returns (uint256) {
        return decimal;
    }

    function _totalSupply() public pure returns (uint256) {
        return totalSupply;
    }

    function mint(uint256 amount, address _to)
        public
        onlyOwner
        returns (uint256)
    {
        circulatingSupply += amount; // increase total circulating supply
        require(circulatingSupply <= totalSupply, "totalSupply Exceeded");
        require(_to != address(0), "mint to address zero ");
        uint256 value = amount * decimal;
        _balance[_to] += value; //increase balance of to
        emit tokenMint(_to, value);
        return value;
    }

    function transfer(address _to, uint256 amount) external {
        require(_to != address(0), "mint to address zero ");
        uint256 userBalance = _balance[msg.sender];
        require(userBalance >= amount, "insufficient funds");
        uint256 _value = amount * decimal;
        uint256 burnableToken = _burn(amount);
        uint256 transferrable = _value - burnableToken;
        _balance[msg.sender] -= _value;
        _balance[_to] += transferrable;
        emit _transfer(msg.sender, _to, amount);
    }

    function _burn(uint256 amount) private returns (uint256 burnableToken) {
        burnableToken = calculateBurn(amount);
        circulatingSupply -= burnableToken;
    }

    function calculateBurn(uint256 amount) public pure returns (uint256 burn) {
        burn = (amount * 10) / 100;
    }

    function balanceOf(address who) public view returns (uint256) {
        return _balance[who];
    }

    ////////////////////////////////////////////////////////////////////////////

    modifier checkBalance(address _owner, uint256 amount) {
        uint256 balance = balanceOf(_owner);
        require(balance >= amount, "insufficient funds");
        _;
    }

    function Approve(address spender, uint256 amount)
        external
        checkBalance(msg.sender, amount)
    {
        require(spender != address(0));
        uint256 allow = _allowance[msg.sender][spender];
        if (allow == 0) {
            _allowance[msg.sender][spender] = amount;
        } else {
            _allowance[msg.sender][spender] += amount;
        }
    }

    function transferFrom(
        address from,
        address _to,
        uint256 amount
    ) external checkBalance(from, amount) {
        require(_to == msg.sender, "not spender");
        uint256 allowanceBalance = _allowance[from][_to];
        require(allowanceBalance >= amount, "no allowance for you");
        _allowance[from][_to] -= amount;
        _balance[from] -= amount;
        uint256 value = amount * decimal;
        _balance[_to] += value;

    }
}
