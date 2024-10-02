// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {MerkleTree} from "../src/36.MerkleTree.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MerkleTreeTest is Test {
    MerkleTree public merkleTree;
    bytes32 public root;

    // Sample addresses and their corresponding token IDs
    address public addr1 = address(0x123);
    address public addr2 = address(0x456);
    uint256 public tokenId1 = 1;
    uint256 public tokenId2 = 2;

    // Sample leaf hashes (keccak256(abi.encodePacked(address)))
    bytes32 public leaf1;
    bytes32 public leaf2;

    // Sample Merkle proof
    bytes32[] public proof1;

    // bytes32[] public proof2;

    function setUp() public {
        // Set up the Merkle tree root
        leaf1 = keccak256(abi.encodePacked(addr1));
        leaf2 = keccak256(abi.encodePacked(addr2));

        // Construct the Merkle root (this is just an example, use your actual Merkle root)
        bytes32[] memory leaves = new bytes32[](2);
        leaves[0] = leaf1;
        leaves[1] = leaf2;
        root = computeMerkleRoot(leaves);
        // console.log("root is ");
        // console.logBytes32(root);

        // Deploy the MerkleTree contract
        merkleTree = new MerkleTree("MyNFT", "MNFT", root);

        // Set up a valid proof for addr1
        proof1 = new bytes32[](1);
        proof1[0] = leaf2;
        // proof2 = new bytes32[](1);
        // proof2[0] = leaf1;
    }

    function testMintSuccess() public {
        // Minting should succeed for addr1
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), addr1, tokenId1);
        merkleTree.mint(addr1, tokenId1, proof1);
        assertEq(merkleTree.ownerOf(tokenId1), addr1);
    }

    function testMintAlreadyMinted() public {
        // Mint for addr1 first
        merkleTree.mint(addr1, tokenId1, proof1);

        // Minting again should fail
        vm.expectRevert("Already minted!");
        merkleTree.mint(addr1, tokenId1, proof1);
    }

    function testMintInvalidProof() public {
        // Create an invalid proof by adding a random hash
        bytes32[] memory invalidProof = new bytes32[](1);
        invalidProof[0] = bytes32("invalid");

        // Minting should fail with invalid proof
        vm.expectRevert("Invalid merkle proof");
        merkleTree.mint(addr2, tokenId2, invalidProof);
    }

    // Helper function to compute Merkle root for testing
    function computeMerkleRoot(
        bytes32[] memory leaves
    ) internal pure returns (bytes32) {
        // Simple implementation for Merkle root calculation
        // In practice, use a proper implementation or library
        if (leaves.length == 0) return bytes32(0);
        if (leaves.length == 1) return leaves[0];

        while (leaves.length > 1) {
            uint256 newLength = (leaves.length + 1) / 2;
            bytes32[] memory newLeaves = new bytes32[](newLength);
            for (uint256 i = 0; i < leaves.length / 2; i++) {
                bytes32 first = leaves[i * 2];
                bytes32 second = leaves[i * 2 + 1];

                // Use ternary operator to choose the order of hashing
                newLeaves[i] = keccak256(
                    abi.encodePacked(
                        first < second ? first : second,
                        first < second ? second : first
                    )
                );
                // console.log("i is ", i);
                // console.log("newLeaves[i] is ");
                // console.logBytes32(newLeaves[i]);
            }
            if (leaves.length % 2 == 1) {
                // console.log("inside if");
                newLeaves[newLength - 1] = leaves[leaves.length - 1];
            }
            leaves = newLeaves;
        }
        return leaves[0];
    }
}
