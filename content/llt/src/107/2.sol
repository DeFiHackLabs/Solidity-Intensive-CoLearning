// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// ----------- 修改器继承 --------- //
contract Base1 {
    modifier exactDividedBy2And3(uint256 _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Base2 is Base1 {
    modifier exactDividedBy2And3(uint256 _a) override {
        _;
        require(_a % 4 == 0 && _a % 6 == 0);
    }

    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {

    }
}

// ----------- 构造函数继承 --------- //
contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}

contract B is A(5){

}

// 常用这种方法
contract C is A{
    constructor (uint _a) A(_a * _a){}
}




