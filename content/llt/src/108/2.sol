// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 接口
interface IERC100 {
    function one() external;
    function two() external;
    function three() external;
}

contract GOGO100 is IERC100 {
    event Log(string msg);

    function one() external {
        emit Log("one");
    }
    function two() external {
        emit Log("two");
    }
    function three() external {
        emit Log("three");
    }
}