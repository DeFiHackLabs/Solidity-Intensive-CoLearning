// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {OtherContract, Call} from "../src/22.Call.sol";

contract CallTest is Test {
    OtherContract private otherContract;
    Call private callContract;

    function setUp() public {
        // Deploy the contracts before each test
        otherContract = new OtherContract();
        callContract = new Call();
    }

    function testSetX() public {
        // Test setting x in OtherContract using Call contract
        uint256 amountToSend = 1 ether;

        vm.expectEmit(true, true, true, false);
        emit OtherContract.Log(amountToSend, 1040379343);
        vm.expectEmit(true, true, true, true);
        emit Call.Response(true, "");
        // Call setX() through the Call contract
        callContract.callSetX{value: amountToSend}(
            payable(address(otherContract)),
            42
        );

        // Assert that the balance is now equal to the amount sent
        assertEq(otherContract.getBalance(), amountToSend);

        // Check the value of x
        uint256 xValue = otherContract.getX();
        assertEq(xValue, 42);
    }

    function testGetX() public {
        vm.expectEmit(true, true, true, true);
        emit Call.Response(true, abi.encode(uint256(0)));
        // Test getting x from OtherContract
        uint256 xValue = callContract.callGetX(address(otherContract));

        // Assert that the retrieved value is correct
        assertEq(xValue, 0); // Initially, _x is set to 0
    }

    function testNonExistFunctionCall() public {
        vm.expectEmit(true, true, true, true);
        emit OtherContract.Log(0, 999);
        emit Call.Response(true, "");
        // Test calling a non-existent function
        callContract.callNonExist(address(otherContract));
    }
}
