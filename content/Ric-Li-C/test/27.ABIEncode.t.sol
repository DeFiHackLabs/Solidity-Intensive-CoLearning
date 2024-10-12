// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {ABIEncode} from "../src/27.ABIEncode.sol";

contract TestABIEncode is Test {
    ABIEncode abiEncode;

    function setUp() public {
        // Deploy the ABIEncode contract
        abiEncode = new ABIEncode();
    }

    function testEncode() public view {
        bytes memory result = abiEncode.encode();

        // Check the length of the encoded result
        assertGt(result.length, 0, "Encoded result should not be empty");

        // Decode the result to verify correctness
        (
            uint x,
            address addr,
            string memory name,
            uint[2] memory array
        ) = abiEncode.decode(result);

        assertEq(x, 10, "Decoded x should be 10");
        assertEq(
            addr,
            0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71,
            "Decoded addr should match the original"
        );
        assertEq(name, "0xAA", "Decoded name should match the original");
        assertEq(array[0], 5, "Decoded array[0] should be 5");
        assertEq(array[1], 6, "Decoded array[1] should be 6");

        console.logBytes(result);
    }

    function testEncodePacked() public view {
        bytes memory result = abiEncode.encodePacked();

        // Check the length of the packed encoded result
        assertGt(result.length, 0, "Packed encoded result should not be empty");

        // Note: We won't decode packed result here since it can lead to ambiguity
        // but we can check its length

        console.logBytes(result);
    }

    function testEncodeWithSignature() public view {
        bytes memory result = abiEncode.encodeWithSignature();

        // Check the length of the encoded result
        assertGt(
            result.length,
            0,
            "Encoded result with signature should not be empty"
        );

        // Decode the result to verify correctness
        // (
        //     uint x,
        //     address addr,
        //     string memory name,
        //     uint[2] memory array
        // ) = abiEncode.decode(result);

        // assertEq(x, 10, "Decoded x should be 10");
        // assertEq(
        //     addr,
        //     0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71,
        //     "Decoded addr should match the original"
        // );
        // assertEq(name, "0xAA", "Decoded name should match the original");
        // assertEq(array[0], 5, "Decoded array[0] should be 5");
        // assertEq(array[1], 6, "Decoded array[1] should be 6");

        console.logBytes(result);
    }

    function testEncodeWithSelector() public view {
        bytes memory result = abiEncode.encodeWithSelector();

        // Check the length of the encoded result
        assertGt(
            result.length,
            0,
            "Encoded result with selector should not be empty"
        );

        // Decode the result to verify correctness
        // (
        //     uint x,
        //     address addr,
        //     string memory name,
        //     uint[2] memory array
        // ) = abiEncode.decode(result);

        // assertEq(x, 10, "Decoded x should be 10");
        // assertEq(
        //     addr,
        //     0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71,
        //     "Decoded addr should match the original"
        // );
        // assertEq(name, "0xAA", "Decoded name should match the original");
        // assertEq(array[0], 5, "Decoded array[0] should be 5");
        // assertEq(array[1], 6, "Decoded array[1] should be 6");

        console.logBytes(result);
    }
}
