// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 简单继承

contract Yeye {
    event Log(string msg);

    function hip() external virtual {
        emit Log("Yeye");
    }

    function yeye() external virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye {
    function hip() external virtual override {
        emit Log("Baba");
    }

    function baba() external virtual {
        emit Log("Baba");
    }
}

contract Erzi is Yeye, Baba {
    function hip() external override(Yeye, Baba) {
        emit Log("Erzi");
    }

    function erzi() external {
        emit Log("Erzi");
    }
}
