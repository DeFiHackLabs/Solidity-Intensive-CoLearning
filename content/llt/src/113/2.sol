// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 发送ETH

contract Helloworld {
    error SendError();
    error callError();

    constructor() payable {}

    function transfer() external {
        payable(msg.sender).transfer(1 ether);
    }

    function send() external {
        bool success = payable(msg.sender).send(1 ether);

        if (!success) {
            revert SendError();
        }
    }

    function call() external {
        (bool success, ) = payable(msg.sender).call{value: 1 ether}("");

        if (!success) {
            revert callError();
        }
    }
}
