// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Pair, PairFactory2} from "../src/25.Create2.sol";

contract TestPairFactory is Test {
    PairFactory2 factory;
    address tokenA = address(0x123);
    address tokenB = address(0x456);

    function setUp() public {
        // Deploy the PairFactory2 contract
        factory = new PairFactory2();
    }

    function testCreatePair2() public {
        // Create a new pair
        address pairAddress = factory.createPair2(tokenA, tokenB);

        // Check that the pair address was returned correctly
        assertTrue(
            pairAddress != address(0),
            "Pair address should not be zero"
        );

        // Check that the pair is registered in the factory
        address registeredPair = factory.getPair(tokenA, tokenB);
        assertEq(
            registeredPair,
            pairAddress,
            "Registered pair should match the created pair"
        );

        // Check that the reverse mapping is also correct
        registeredPair = factory.getPair(tokenB, tokenA);
        assertEq(
            registeredPair,
            pairAddress,
            "Reverse registered pair should match the created pair"
        );
    }

    function testInitializePair() public {
        // Create a new pair
        address pairAddress = factory.createPair2(tokenA, tokenB);

        // Cast the address to the Pair contract
        Pair pair = Pair(pairAddress);

        // Verify that the tokens were initialized correctly
        assertEq(
            pair.token0(),
            tokenA,
            "Token0 should be initialized to tokenA"
        );
        assertEq(
            pair.token1(),
            tokenB,
            "Token1 should be initialized to tokenB"
        );
    }

    function testOnlyFactoryCanInitialize() public {
        // Create a new pair
        address pairAddress = factory.createPair2(tokenA, tokenB);
        Pair pair = Pair(pairAddress);

        // Attempt to initialize the pair from a different address
        address maliciousAddress = address(0x789);

        // This should revert since the caller is not the factory
        vm.expectRevert("UniswapV2: FORBIDDEN");
        pair.initialize(maliciousAddress, tokenB);
    }

    function testCalculateAddr() public {
        // Calculate the predicted address
        address predictedAddress = factory.calculateAddr(tokenA, tokenB);

        // Create a new pair to get the actual address
        address actualPairAddress = factory.createPair2(tokenA, tokenB);

        // Verify that the predicted address matches the actual address
        assertEq(
            predictedAddress,
            actualPairAddress,
            "Predicted address should match the actual pair address"
        );
    }

    function testIdenticalAddresses() public {
        // Attempt to create a pair with identical addresses
        vm.expectRevert("IDENTICAL_ADDRESSES");
        factory.createPair2(tokenA, tokenA);
    }
}
