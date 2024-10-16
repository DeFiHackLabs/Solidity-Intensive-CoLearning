// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// create2

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
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair2(address tokenA, address tokenB)
        external
        returns (address pairAddr)
    {
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES"); //避免tokenA和tokenB相同产生的冲突
        // 用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 用create2部署新合约
        Pair pair = new Pair{salt: salt}();
        // 调用新合约的init方法
        pair.init(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }

    // 提前计算pair合约地址
    function calculateAddr(address tokenA, address tokenB)
        public
        view
        returns (address predictedAddress)
    {
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES"); //避免tokenA和tokenB相同产生的冲突
        // 计算用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 计算合约地址方法 hash()
        predictedAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            salt,
                            keccak256(type(Pair).creationCode)
                        )
                    )
                )
            )
        );

        //type(C).name(string):合約的名称
        //type(C).creationCode(bytes memory):合約的创建字节码
        //type(C).runtimeCode(bytes memory):合約的运行时字节码
        //type(I).interfaceId(bytes4):包含给定接口的 EIP-165 接口标示符
        //type(T).min(T):整型 T 的最小值
        // type(T).max(T):整型 T 的最大值
    }
}
