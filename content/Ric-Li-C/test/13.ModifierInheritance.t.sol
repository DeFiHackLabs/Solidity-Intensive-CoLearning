// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Identifier} from "../src/13.ModifierInheritance.sol";

contract TestIdentifier is Test {
    Identifier identifier;

    function setUp() public {
        // Deploy the Identifier contract
        identifier = new Identifier();
    }

    function testGetExactDividedBy2And3_ValidInput() public view {
        // Test with a valid input (6, which is a multiple of 2 and 3)
        (uint div2, uint div3) = identifier.getExactDividedBy2And3(6);

        assertEq(div2, 3, "6 / 2 should equal 3");
        assertEq(div3, 2, "6 / 3 should equal 2");
    }

    function testGetExactDividedBy2And3_InvalidInput() public {
        // Expect revert when input is not a multiple of 2 and 3 (e.g., 9)
        vm.expectRevert();
        identifier.getExactDividedBy2And3(9);
    }

    function testGetExactDividedBy2And3WithoutModifier_ValidInput()
        public
        view
    {
        // Test the method without the modifier to ensure it works
        (uint div2, uint div3) = identifier
            .getExactDividedBy2And3WithoutModifier(9);

        assertEq(
            div2,
            4,
            "9 / 2 should equal 4.5, but returns 4 since it's integer division"
        );
        assertEq(div3, 3, "9 / 3 should equal 3");
    }
}
