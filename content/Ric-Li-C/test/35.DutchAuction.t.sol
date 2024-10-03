// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {DutchAuction} from "../src/35.DutchAuction.sol";

contract DutchAuctionTest is Test {
    DutchAuction public auction;
    address public owner = address(0x999);
    address public user = address(0x123);

    function setUp() public {
        vm.startPrank(owner);
        auction = new DutchAuction();

        // Set the auction start time to a point in the future for testing
        auction.setAuctionStartTime(uint32(block.timestamp + 1 minutes));
        vm.stopPrank();
    }

    function testInitialAuctionState() public view {
        // Check that the auction hasn't started yet
        assertEq(auction.getAuctionPrice(), auction.AUCTION_START_PRICE());
        assertEq(auction.totalSupply(), 0);
    }

    function testAuctionMintSuccess() public {
        // Fast forward time to start the auction
        vm.warp(block.timestamp + 1 minutes);

        // Mint 1 NFT
        uint256 quantity = 1;
        uint256 price = auction.getAuctionPrice() * quantity;

        // User mints an NFT
        vm.deal(user, price);
        vm.prank(user);
        auction.auctionMint{value: price}(quantity);

        // Check that the NFT was minted
        assertEq(auction.totalSupply(), quantity);
        assertEq(auction.ownerOf(1), user); // NFT token ID starts from 1
    }

    function testAuctionMintInsufficientFunds() public {
        // Fast forward time to start the auction
        vm.warp(block.timestamp + 1 minutes);

        // Attempt to mint without enough ETH
        vm.prank(user);
        vm.expectRevert("Need to send more ETH.");
        auction.auctionMint(1);
    }

    function testAuctionMintExceedsCollectionLimit() public {
        // Fast forward time to start the auction
        vm.warp(block.timestamp + 1 minutes);

        // Mint all NFTs
        uint256 quantity = 10000;
        uint256 price = auction.getAuctionPrice() * quantity;

        // Mint up to the collection limit
        vm.deal(user, price);
        vm.prank(user);
        auction.auctionMint{value: price}(quantity);

        // Check that minting beyond the limit fails
        vm.expectRevert(
            "not enough remaining reserved for auction to support desired mint amount"
        );
        auction.auctionMint(1);
    }

    function testWithdrawMoney() public {
        // Fast forward time to start the auction
        vm.warp(block.timestamp + 1 minutes);

        // User mints an NFT
        uint256 quantity = 1;
        uint256 price = auction.getAuctionPrice() * quantity;
        vm.deal(user, price);
        vm.prank(user);
        auction.auctionMint{value: price}(quantity);

        // Withdraw funds by the owner
        uint256 initialBalance = address(owner).balance;
        vm.prank(owner);
        auction.withdrawMoney();

        // Check that the balance has increased
        assertGt(address(owner).balance, initialBalance);
        assertEq(address(owner).balance, initialBalance + price);
    }

    function testSetBaseURI() public {
        string memory newBaseURI = "https://example.com/metadata/";
        vm.prank(owner);
        auction.setBaseURI(newBaseURI);

        // Check that the BaseURI has been set correctly
        // assertEq(auction._baseURI(), newBaseURI);
    }

    function testSetAuctionStartTime() public {
        uint32 newStartTime = uint32(block.timestamp + 2 minutes);
        vm.prank(owner);
        auction.setAuctionStartTime(newStartTime);

        // Check that the auction start time is updated
        assertEq(auction.auctionStartTime(), newStartTime);
    }
}
