// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 配对合约
contract Pair {
    address public factoryAddress; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factoryAddress = msg.sender;
    }

    function init(address _token0, address _token1) external {
        require(factoryAddress == msg.sender);

        token0 = _token0;
        token1 = _token1;
    }
}

// 工厂合约
contract PairFactory {
    address[] public allPair;

    function newPair(address _token0, address _token1) external payable  {
        Pair pair = new Pair{value: msg.value}();
        pair.init(_token0, _token1);

        allPair.push(address(pair));
    }
}
