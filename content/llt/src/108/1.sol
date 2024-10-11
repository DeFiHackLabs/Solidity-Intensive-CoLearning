// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 抽象合约
abstract contract A {
    function hello() external virtual;
}

contract B is A{
    event Log(string msg);

    function hello() external override {
        emit Log("hello");
    }
}