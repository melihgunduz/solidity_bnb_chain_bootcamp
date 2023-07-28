// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

// 1 ether = 10^18 wei
contract Bank {

    mapping(address => uint) private balances;

    address public owner;

    modifier insufficientBalance(uint _amount) {
        
        require(balances[msg.sender] >= _amount,"Insufficient deposit");
        _;

    }

    modifier onlyOwner() {
        require(msg.sender == owner,"you are not owner");
        _;
    }
    constructor() {
        owner = msg.sender;
    }

    function getBankBalance() public view returns(uint) {
        return address(this).balance;
    }


    function deposit(uint _amount) public payable {
        require(msg.value == _amount,"Msg.value and _amount are not equal");
        balances[msg.sender] += _amount;

    }

    function withdraw(uint _amount) public insufficientBalance(_amount) onlyOwner{
        
        balances[msg.sender] -= _amount;

        payable(msg.sender).transfer(_amount);
    }

    function getBalance(address _account) public view returns(uint){
        return balances[_account];
    }

    function transferTo(address recipient, uint _amount) public insufficientBalance(_amount){
        balances[msg.sender] -= _amount;
        balances[recipient] += _amount;
    }


    receive() external payable {
        revert();
    }

}