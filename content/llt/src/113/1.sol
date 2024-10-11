// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 接收ETH

contract Helloworld {
    event Receive(uint amount);
    event Fallback(uint amount);

    receive() external payable {
        emit Receive(msg.value);
    }

    fallback() external payable {
        emit Fallback(msg.value);
    }
}
