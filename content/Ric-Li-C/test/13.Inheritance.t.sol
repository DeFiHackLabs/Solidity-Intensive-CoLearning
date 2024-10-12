// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Yeye, Baba, Erzi, A, B, C} from "../src/13.Inheritance.sol";

contract TestInheritance is Test {
    Yeye yeye;
    Baba baba;
    Erzi erzi;
    B b;
    C c;

    function setUp() public {
        // Deploy contracts
        yeye = new Yeye();
        baba = new Baba();
        erzi = new Erzi();
        b = new B();
        c = new C(3); // Example value for C
    }

    function testYeyeHip() public {
        // Test hip function in Yeye
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Yeye");
        yeye.hip();
    }

    function testYeyePop() public {
        // Test pop function in Yeye
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Yeye");
        yeye.pop();
    }

    function testYeyeYeye() public {
        // Test yeye function in Yeye
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Yeye");
        yeye.yeye();
    }

    function testBabaHip() public {
        // Test hip function in Baba
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Baba");
        baba.hip();
    }

    function testBabaPop() public {
        // Test pop function in Baba
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Baba");
        baba.pop();
    }

    function testErziHip() public {
        // Test hip function in Erzi
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Erzi");
        erzi.hip();
    }

    function testErziPop() public {
        // Test pop function in Erzi
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Erzi");
        erzi.pop();
    }

    function testCallParent() public {
        // Test calling parent function pop from Yeye
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Yeye");
        erzi.callParent();
    }

    function testCallParentSuper() public {
        // Test calling overridden parent function pop from Baba
        vm.expectEmit(true, true, true, true);
        emit Yeye.Log("Baba");
        erzi.callParentSuper();
    }

    function testBConstructor() public view {
        // Test the constructor of B
        assertEq(b.a(), 1, "B should have a value of 1");
    }

    function testCConstructor() public view {
        // Test the constructor of C
        assertEq(c.a(), 9, "C should have a value of 9 (3 * 3)");
    }
}
