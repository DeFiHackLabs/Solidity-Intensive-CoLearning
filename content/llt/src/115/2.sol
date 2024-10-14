// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// delegatecall
contract B {
    uint public number;
    string public name;

    function setNumber(uint _number,address _addr) external {
        // call 改变的是C合约的number
        (bool seccess,) = _addr.call(abi.encodeWithSignature("setNumber(uint256)", _number));

        require(seccess);
    }

    function setName(string memory _name,address _addr) external {
        // delegatecall 改变的是B合约的name
        (bool seccess,) = _addr.delegatecall(abi.encodeWithSignature("setName(string)", _name));

        require(seccess);
    }
}

contract C {
    uint public number;
    string public name;

    function setNumber(uint _number) external {
        number = _number;
    }

    function setName(string memory _name) external {
        name = _name;
    }
}

