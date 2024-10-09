// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {C, B} from "../src/23.Delegatecall.sol";

contract TestB is Test {
    B b;
    C c;

    function setUp() public {
        // Deploy contract C
        c = new C();

        // Deploy contract B
        b = new B();
    }

    function testCallSetVars() public {
        uint256 testNum = 42;

        // Call setVars on contract C through contract B
        b.callSetVars(address(c), testNum);

        // Assert that the state variables in contract C are updated
        assertEq(c.num(), testNum, "Contract C num should be updated");
        assertEq(
            c.sender(),
            address(b),
            "Contract C sender should be contract B"
        );
    }

    function testDelegatecallSetVars() public {
        uint256 testNum = 100;

        // Call setVars on contract C through delegatecall from contract B
        b.delegatecallSetVars(address(c), testNum);

        // Assert that the state variables in contract B are updated
        assertEq(b.num(), testNum, "Contract B num should be updated");
        assertEq(
            b.sender(),
            address(this),
            "Contract B sender should be this address"
        );
    }
}
