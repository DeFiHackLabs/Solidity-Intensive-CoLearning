// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {DataStorage, Variables} from "../src/05.DataStorage_v2.sol";

contract DataStorageTest is Test {
    DataStorage public dataStorage;
    Variables public variables;

    function setUp() public {
        dataStorage = new DataStorage();
        variables = new Variables();
    }

    function testStorageMemory() public {
        dataStorage.fStorage2Storage();
        dataStorage.fStorage2Memory();
        dataStorage.fMemory2Memory();
        dataStorage.fMemory2Storage();
    }

    function testLocalStorage() public {
        dataStorage.fStorage2LocalStorage();
    }

    function testMemory2Memory_uint() public view {
        dataStorage.fMemory2Memory_uint();
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