// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    uint256 public number = 5;

    function add() external {
        number = number + 1;
    }

    function addPure(uint _number) external pure returns(uint new_number) {
        new_number = _number + 1;
    }

    function addView() external view returns(uint new_number){
       new_number = number + 1;
    }

    // internal: 内部函数
    function minus() internal {
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }

    // payable: 递钱，能给合约支付eth的函数
    function minusPayable() external payable returns (uint256 balance) {
        minus();
        balance = address(this).balance;
    }
}