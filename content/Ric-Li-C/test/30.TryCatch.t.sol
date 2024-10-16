// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {OnlyEven, TryCatch} from "../src/30.TryCatch.sol";

contract TestTryCatch is Test {
    TryCatch tryCatch;

    function setUp() public {
        // Deploy the TryCatch contract
        tryCatch = new TryCatch();
    }

    function testExecute_Success() public {
        // Test the execute function with an even number
        bool success = tryCatch.execute(0);
        assertTrue(success, "execute should succeed for even number");

        // Check that the SuccessEvent was emitted
        vm.expectEmit(true, true, true, true);
        emit TryCatch.SuccessEvent();
        tryCatch.execute(0);
    }

    function testExecute_Failure() public {
        // Test the execute function with an odd number
        vm.expectEmit(true, true, true, true);
        emit TryCatch.CatchEvent("Ups! Reverting");

        tryCatch.execute(1);
    }

    function testExecuteNew_Success() public {
        // Test the executeNew function with an even number
        bool success = tryCatch.executeNew(2);
        assertTrue(success, "executeNew should succeed for even number");

        // Check that the SuccessEvent was emitted
        vm.expectEmit(true, true, true, true);
        emit TryCatch.SuccessEvent();
        tryCatch.executeNew(2);
    }

    function testExecuteNew_Failure() public {
        // Test the executeNew function with an odd number
        vm.expectEmit(true, true, true, true);
        // emit TryCatch.CatchEvent("invalid number");
        emit TryCatch.CatchByte(
            hex"4e487b710000000000000000000000000000000000000000000000000000000000000001"
        );

        tryCatch.executeNew(1);
    }

    function testExecuteNew_FailureAssert() public {
        // Test the executeNew function with 0
        vm.expectEmit(true, true, true, true);
        emit TryCatch.CatchEvent("invalid number");

        tryCatch.executeNew(0);
    }
}
