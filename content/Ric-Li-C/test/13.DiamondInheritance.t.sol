// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {God, Adam, Eve, people} from "../src/13.DiamondInheritance.sol";

contract TestInheritance is Test {
    // God god;
    // Adam adam;
    // Eve eve;
    people p;

    function setUp() public {
        // No need to deploy these three contracts
        // god = new God();
        // adam = new Adam();
        // eve = new Eve();

        // Deploy the people contract
        p = new people();
    }

    function testFoo() public {
        // Expect the Log events in the order they should be called
        vm.expectEmit(true, true, true, true);
        emit God.Log("Eve.foo called");

        vm.expectEmit(true, true, true, true);
        emit God.Log("Adam.foo called");

        vm.expectEmit(true, true, true, true);
        emit God.Log("God.foo called");

        // Call foo on the people contract
        p.foo();
    }

    function testBar() public {
        // Expect the Log events in the order they should be called
        vm.expectEmit(true, true, true, true);
        emit God.Log("Eve.bar called");

        vm.expectEmit(true, true, true, true);
        emit God.Log("Adam.bar called");

        vm.expectEmit(true, true, true, true);
        emit God.Log("God.bar called");

        // Call bar on the people contract
        p.bar();
    }
}
