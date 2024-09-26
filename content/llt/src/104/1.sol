// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    // mapping(uint256 => address) public idToAddress; // id映射到地址
    // mapping(address => address) public swapPair; // 币对的映射，地址到地址

    // // 给mapping赋值
    // function writeMap(uint256 _Key, address _Value) external  {
    //     idToAddress[_Key] = _Value;
    // }

    // 变量初始值

    // 值类型
    bool public _bool; // false
    string public _string; // ""
    int256 public _int; // 0
    uint256 public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet {
        Buy,
        Hold,
        Sell
    }
    ActionSet public _enum; // 第1个内容Buy的索引0

    function fi() internal {} // internal空白函数

    function fe() external {} // external空白函数

    // 引用类型
    // Reference Types
    uint256[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint256[] public _dynamicArray; // `[]`
    mapping(uint256 => address) public _mapping; // 所有元素都为其默认值的mapping
    // 所有成员设为其默认值的结构体 0, 0
    struct Student {
        uint256 id;
        uint256 score;
    }
    Student public student;

    // delete 操作符
    uint[] arr= [1,2,3];

    function changeArr() public{
        arr[0] = 8;
        arr.push();
    }

    function deleteArr() public{
        delete arr;
    }

    function getArr() external view returns (uint[] memory) {
        return arr;
    }
}
