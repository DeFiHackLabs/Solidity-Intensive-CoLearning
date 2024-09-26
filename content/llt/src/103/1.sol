// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    // 存储方式
    // 同一存储类型赋值指向同一个地址，改变值相同存储类型的变量值也同步改变
    // uint256[] public  x = [1, 2, 3];

    // function myStorage() external   {
    //     uint256[] storage _x = x;
    //     _x[0] = 100;
    // }

    // function myMemory() external view {
    //     uint256[] memory _x = x;
    //     _x[0] = 100;
    // }

    // function myCalldata(uint256[] calldata _x)
    //     external
    // {
    //     //参数为calldata数组，不能被修改
    //      x = _x;
    // }

    uint256 public x = 1;
    uint256 public y;
    string public z;

    // 状态变量
    function change1() external {
        x = 5;
        y = 2;
        z = "0xAA";
    }

    // 局部变量This declaration shadows an existing declaration.
    function change2() external pure returns (uint256) {
        uint256 a = 1;
        uint256 b = 2;
        return a + b;
    }

    // 全局变量
    function change3()
        external
        payable
        returns (
            address sender,
            bytes memory data,
            uint256 value
        )
    {
        sender = msg.sender;
        data = msg.data;
        value = msg.value;
    }

    // 单位
    function change4() external pure returns (uint256 wei1,uint256 hours1 ) {
        wei1  = 1 wei;
        hours1 = 1 hours;
    }
}
