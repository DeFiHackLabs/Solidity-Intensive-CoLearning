// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    // uint256要写全，不能简写成uint,不然签名会与底层不一样，因为底层会把uint编译为uint256
    event Transfer(address indexed from, address indexed to, uint256 value);

    uint256 public a = 0;

    function transfer(
        address from,
        address to,
        uint256 value
    ) external {
        a = value;

        emit Transfer(from, to, value);
    }
}