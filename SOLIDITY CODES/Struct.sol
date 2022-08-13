// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;
import './Count.sol';
function get() pure returns(uint){
    return NUM;
}
contract Structs{
    
    struct Student{
        string name;
        uint age;
        uint[] score;
    }

        address public owner;
    constructor(){
        owner = msg.sender;
    }

        //mapping
        mapping(address => Student) student;

        //array of recorded students
        Student[] Students; 


            modifier onlyOwner(){
                require(msg.sender == owner, "sorry you are not admin");
                _;
            }

        function InitRec(string memory _name, uint _age, uint[] memory _score) public onlyOwner{
                Student storage studentRec = student[msg.sender];
                studentRec.name = _name;
                studentRec.age = _age;
                studentRec.score = _score;
                Students.push(studentRec);
        }

        // get record for a student base on their index
        function recForAStudent(uint index) public view returns(Student memory){
            return Students[index];
        }


        // get record for all students
        function recForAllStudent()public view returns(Student[]memory){
            return Students;

        }

        // update score for a student
        // function updateScore(uint _index, uint _score) public onlyOwner{
        //     Students[_index] s;
        // }

           function constantUP() public pure returns(uint, uint){
        return(1, get());
    }
}