// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

contract Limiter {
   mapping(address => uint) private balances;

   uint limit;

   modifier insufficientBalance(uint _amount) {
      require(balances[msg.sender] >= _amount, "Insufficient deposit");
      _;
   }

   modifier checkLimit(uint _amount) {
      require(limit > 0, "You have to set limit");
      require(limit >= _amount, "You exceed the limits");
      _;
   }

   function setLimit(uint _amount) public {
      limit = _amount;
   }

   function deposit(uint _amount) public payable insufficientBalance(_amount) checkLimit(_amount) {
      balances[msg.sender] += _amount;
   }

   receive() external payable {
      revert();
   }
}
