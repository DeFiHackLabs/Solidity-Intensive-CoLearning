// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {MerkleTree} from "../src/36.MerkleTree_v2.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MerkleTreeTest is Test {
    MerkleTree public merkleTree;
    bytes32 public root;

    // Sample addresses and their corresponding token IDs
    address public addr1 = 0x41F669e9c3dCDBf71d2C60843BfDC47bCE257081;
    address public addr2 = 0x7E60F5E4544F8817A1D49bD3bB14c1EE2E7537cC;
    address public addr3 = 0xAFA99d32d590c4cE6d1591cb4E384033D27343F4;
    address public addr4 = 0x0aF5b972F0cD498c389974C96C0e1FEb5B8d0b20;
    address public addr5 = 0xb72f70C0EA5462D39A26c635448ce2A0849d7f1E;
    address public addr6 = 0xB28ac214922A05cD7Be55cA492B6339090AF3d1C;
    uint256 public tokenId1 = 1;
    uint256 public tokenId2 = 2;

    // Sample leaf hashes (keccak256(abi.encodePacked(address)))
    bytes32 public leaf1;
    bytes32 public leaf2;
    bytes32 public leaf3;
    bytes32 public leaf4;
    bytes32 public leaf5;
    bytes32 public leaf6;

    // Sample branch hashes
    bytes32 public branch1;
    bytes32 public branch2;
    bytes32 public branch3;

    // Sample trunk hashes
    bytes32 public trunk1;
    bytes32 public trunk2;

    // Sample Merkle proof
    bytes32[] public proof1;

    // bytes32[] public proof1 = [
    //     bytes32(
    //         0xef89e23bc1d7f0e3f9a7f997891e961aa13f491651ceb5e1d0f506d2b1f35161
    //     ),
    //     0x30f02d82ef0304cd04cbebbe710f07e2094bfcd3853eb16de0282c85e2a4111b,
    //     0x9de4e68f8b0572c31c499f82f1aac0c37289a1f26e8afa5b24b5cd88d83e9de4
    // ];

    function setUp() public {
        // Set up the Merkle tree root
        leaf1 = keccak256(abi.encodePacked(addr1));
        leaf2 = keccak256(abi.encodePacked(addr2));
        leaf3 = keccak256(abi.encodePacked(addr3));
        leaf4 = keccak256(abi.encodePacked(addr4));
        leaf5 = keccak256(abi.encodePacked(addr5));
        leaf6 = keccak256(abi.encodePacked(addr6));

        // Construct the Merkle root (this is just an example, use your actual Merkle root)
        bytes32[] memory leaves = new bytes32[](6);
        leaves[0] = leaf1;
        leaves[1] = leaf2;
        leaves[2] = leaf3;
        leaves[3] = leaf4;
        leaves[4] = leaf5;
        leaves[5] = leaf6;
        root = computeMerkleRoot(leaves);
        // console.log("root is ");
        // console.logBytes32(root);

        // Deploy the MerkleTree contract
        merkleTree = new MerkleTree("MyNFT", "MNFT", root);

        branch1 = computeHash(leaf1, leaf2);
        branch2 = computeHash(leaf3, leaf4);
        // console.log("branch2 is ");
        // console.logBytes32(branch2);
        branch3 = computeHash(leaf5, leaf6);

        trunk1 = computeHash(branch1, branch2);
        trunk2 = branch3;
        // console.log("trunk2 is ");
        // console.logBytes32(trunk2);

        // Set up a valid proof for addr1
        proof1 = new bytes32[](3);
        proof1[0] = leaf2;
        proof1[1] = branch2;
        proof1[2] = trunk2;
    }

    function testMintSuccess() public {
        // Minting should succeed for addr1
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), addr1, tokenId1);
        merkleTree.mint(addr1, proof1);
        assertEq(merkleTree.ownerOf(tokenId1), addr1);
    }

    function testMintAlreadyMinted() public {
        // Mint for addr1 first
        merkleTree.mint(addr1, proof1);

        // Minting again should fail
        vm.expectRevert("Already minted!");
        merkleTree.mint(addr1, proof1);
    }

    function testMintInvalidProof() public {
        // Create an invalid proof by adding a random hash
        bytes32[] memory invalidProof = new bytes32[](1);
        invalidProof[0] = bytes32("invalid");

        // Minting should fail with invalid proof
        vm.expectRevert("Invalid merkle proof");
        merkleTree.mint(addr2, invalidProof);
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
                newLeaves[i] = computeHash(leaves[i * 2], leaves[i * 2 + 1]);
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

    // Helper function to compute Merkle hash for testing
    function computeHash(
        bytes32 first,
        bytes32 second
    ) internal pure returns (bytes32) {
        // Use ternary operator to choose the order of hashing
        return
            keccak256(
                abi.encodePacked(
                    first < second ? first : second,
                    first < second ? second : first
                )
            );
    }
}
