// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console} from "forge-std/Test.sol";

contract DataStorage {
    // The data location of xStorage1 is storage.
    // This is the only place where the
    // data location can be omitted.
    uint[] public xStorage1 = [1,2,3];
    uint[] public xStorage2;
    uint[] public xStorage3 = [1,2,3];
    uint[] public xStorage4 = [1,2,3];
    uint[] public xStorage5;

    function fStorage2Storage() public {
        //storage的变量xStorage2，复制xStorage1
        xStorage2 = xStorage1;

        //修改xStorage1不会影响xStorage2
        xStorage1[0] = 100;
        assert(xStorage2[0] == 1);
        // console.log('xStorage2[0] is', xStorage2[0]);

        //修改xStorage2也不会影响xStorage1
        xStorage2[1] = 200;
        assert(xStorage1[1] == 2);
        // console.log('xStorage1[1] is', xStorage1[1]);
    }

    function fStorage2LocalStorage() public {
        //声明一个local storage的变量localStorage1，复制xStorage3(指向xStorage3)
        uint[] storage localStorage1 = xStorage3;

        //修改xStorage3会影响localStorage1
        xStorage3[0] = 100;
        assert(localStorage1[0] == 100);
        // console.log('localStorage1[0] is', localStorage1[0]);

        //修改localStorage1也会影响xStorage3
        localStorage1[1] = 200;
        assert(xStorage3[1] == 200);
        // console.log('xStorage3[1] is', xStorage3[1]);
    }

    //`LocalStorage2...` are not possible as local storage array can only be initialized by assigning storage array.
    // function fLocalStorage2LocalStorage() public {
    //     uint[] storage localStorage2;
        // localStorage2.push(1);
    // }

    function fStorage2Memory() public {
        //声明一个Memory的变量xMemory，复制xStorage4。
        uint[] memory xMemory = xStorage4;
        
        //修改xStorage4不会影响xMemory
        xStorage4[0] = 100;        
        assert(xMemory[0] == 1);
        
        //修改xMemory也不会影响xStorage4
        xMemory[1] = 200;        
        assert(xStorage4[1] == 2);
    }

    function fMemory2Memory() public pure {
        //声明一个Memory的变量xMemory。
        uint[] memory xMemory = new uint[](3);
        xMemory[0] = 1;
        xMemory[1] = 2;
        xMemory[2] = 3;
        //声明一个Memory的变量xMemory2，复制xMemory。
        uint[] memory xMemory2 = xMemory;
        
        //修改xMemory会影响xMemory2
        xMemory[0] = 100;        
        assert(xMemory2[0] == 100);
        // console.log('xMemory2[0] is', xMemory2[0]);
        
        //修改xMemory2也会影响xMemory
        xMemory2[1] = 200;        
        assert(xMemory[1] == 200);
        // console.log('xMemory[1] is', xMemory[1]);
    }

    function fMemory2Memory_uint() public pure {
        //声明一个变量xMemory1(Memory变量)。
        uint xMemory1 = 1;
        //声明一个变量xMemory2(Memory变量)，复制xMemory1。
        uint xMemory2 = xMemory1;
        
        //修改xMemory1不会影响xMemory2
        xMemory1 = 100;        
        assert(xMemory2 == 1);
        // console.log('xMemory2 is', xMemory2);
        
        //修改xMemory2也不会影响xMemory1
        xMemory2 = 200;        
        assert(xMemory1 == 100);
        // console.log('xMemory1 is', xMemory1);
    }

    function fMemory2Storage() public {
        //声明一个Memory的变量xMemory。
        uint[] memory xMemory = new uint[](3);
        xMemory[0] = 1;
        xMemory[1] = 2;
        xMemory[2] = 3;
        
        // Cannot directly convert a memory array into a storage array because they are fundamentally different data locations.
        // Copy values from the memory array to the storage array.
        for (uint i = 0; i < xMemory.length; i++) {
            xStorage5.push(xMemory[i]); // Add each element from memory to storage
        }
        
        //From the way value is copied, we know
        //修改xMemory不会影响xStorage5
        xMemory[0] = 100;        
        assert(xStorage5[0] == 1);
        
        //From the way value is copied, we know
        //修改xStorage5也不会影响xMemory
        xStorage5[1] = 200;        
        assert(xMemory[1] == 2);
    }

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return(_x);
    }
}

contract Variables {
    uint public x = 1;
    uint public y;
    string public z;

    function foo() external{
        // 可以在函数里更改状态变量的值
        x = 5;
        y = 2;
        z = "0xAA";
    }

    function bar() external pure returns(uint){
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }

    function global() external view returns(address, uint, bytes memory){
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }

    function weiUnit() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns(uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure returns(uint) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }
    
    function secondsUnit() external pure returns(uint) {
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUnit() external pure returns(uint) {
        assert(1 minutes == 60);
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUnit() external pure returns(uint) {
        assert(1 hours == 3600);
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function daysUnit() external pure returns(uint) {
        assert(1 days == 86400);
        assert(1 days == 24 hours);
        return 1 days;
    }

    function weeksUnit() external pure returns(uint) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }
}