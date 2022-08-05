// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <=0.8.15;

contract Test {
    function deposit() public payable {
        require(msg.value > 0, "Must be greater than 0");
    }

    mapping(address => uint256) balances;
    uint256 public deadline = 0;

    function stake() public payable {
        require(msg.value > 0, "Input value");
        require(block.timestamp > deadline, "Wait until 30sec");
        balances[msg.sender] += msg.value;
    }

    function withdraw() public payable {
        require(block.timestamp > deadline, "");
        require(balances[msg.sender] > 0, "No amount staked");
        payable(msg.sender).transfer(balances[msg.sender]);
    }

    fallback() external payable {}

    receive() external payable {}
}
