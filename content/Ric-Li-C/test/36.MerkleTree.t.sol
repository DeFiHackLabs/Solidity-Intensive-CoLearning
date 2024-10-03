// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {MerkleTree} from "../src/36.MerkleTree.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MerkleTreeTest is Test {
    MerkleTree public merkleTree;

    // Calculated from https://lab.miguelmota.com/merkletreejs/example/
    bytes32 public root =
        0xeeefd63003e0e702cb41cd0043015a6e26ddb38073cc6ffeb0ba3e808ba8c097;

    // Sample addresses and their corresponding token IDs
    address public addr1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public addr2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public addr3 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public addr4 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    uint256 public tokenId1 = 1;
    uint256 public tokenId2 = 2;

    // Sample Merkle proof
    bytes32[] public proof1 = [
        bytes32(
            0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb
        ),
        0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c
    ];

    function setUp() public {
        // Deploy the MerkleTree contract
        merkleTree = new MerkleTree("MyNFT", "MNFT", root);
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
}
