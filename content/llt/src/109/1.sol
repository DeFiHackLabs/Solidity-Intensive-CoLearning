// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 异常

error NotOwner();

contract HelloWorld {
    uint256 public number = 0;

    function one() external {
        if (msg.sender != 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)
            revert NotOwner();
        number++;
    }

    function two() external {
        require(
            msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            "Not Owner!"
        );
        number++;
    }

    function three() external {
        assert(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        number++;
    }
}
