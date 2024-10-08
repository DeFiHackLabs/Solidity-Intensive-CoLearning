// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {DataStorage, Variables} from "../src/05.DataStorage.sol";

contract DataStorageTest is Test {
    DataStorage public dataStorage;
    Variables public variables;

    function setUp() public {
        dataStorage = new DataStorage();
        variables = new Variables();
    }

    function testFStorage() public {
        // Solidity handles dynamic arrays in the context of public state variables. 
        // When accessing a public array like x, it returns a single element (not the entire array) by default.
        // So we can not use `uint[] memory initialArray = dataStorage.x()`
        uint[] memory initialArray = dataStorage.getArray();
        assertEq(initialArray[0], 1); // Initial value should be 1

        dataStorage.fStorage();

        uint[] memory updatedArray = dataStorage.getArray();
        assertEq(updatedArray[0], 100); // Value should be updated to 100
    }

    function testFMemory() public view {
        uint[] memory initialArray = dataStorage.getArray();
        assertEq(initialArray[0], 1); // Initial value should be 1

        dataStorage.fMemory();

        // Memory change does not affect the storage array
        uint[] memory afterMemoryCall = dataStorage.getArray();
        assertEq(afterMemoryCall[0], 1); // Should still be 1
        assertEq(afterMemoryCall[1], 2); // Should still be 2
        assertEq(afterMemoryCall[2], 3); // Should still be 3
    }

    function testVariables() public {
        assertEq(variables.x(), 1); // initial x value should be 1
        assertEq(variables.y(), 0); // initial y value should be 0
        assertEq(variables.z(), ""); // initial z value should be ""
        variables.foo();
        assertEq(variables.x(), 5); // x should be updated to 5
        assertEq(variables.y(), 2); // y should be updated to 2
        assertEq(variables.z(), "0xAA"); // z should be set to "0xAA"
    }

    function testBar() public view {
        uint result = variables.bar();
        assertEq(result, 4); // 1 + 3 = 4
    }

    function testGlobal() public view {
        (address sender, uint blockNum, bytes memory data) = variables.global();
        assertEq(sender, address(this)); // sender should be the contract address
        assertEq(blockNum, block.number); // block number should match the current block
        assertEq(data, abi.encodeWithSignature("global()")); // msg.data should match function signature of `global()`
    }

    function testWeiUnit() public view {
        uint result = variables.weiUnit();
        assertEq(result, 1 wei);
    }

    function testGweiUnit() public view {
        uint result = variables.gweiUnit();
        assertEq(result, 1 gwei);
    }

    function testEtherUnit() public view {
        uint result = variables.etherUnit();
        assertEq(result, 1 ether);
    }

    function testSecondsUnit() public view {
        uint result = variables.secondsUnit();
        assertEq(result, 1 seconds);
    }

    function testMinutesUnit() public view {
        uint result = variables.minutesUnit();
        assertEq(result, 1 minutes);
    }

    function testHoursUnit() public view {
        uint result = variables.hoursUnit();
        assertEq(result, 1 hours);
    }

    function testDaysUnit() public view {
        uint result = variables.daysUnit();
        assertEq(result, 1 days);
    }

    function testWeeksUnit() public view {
        uint result = variables.weeksUnit();
        assertEq(result, 1 weeks);
    }
}