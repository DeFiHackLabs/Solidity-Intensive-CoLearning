
### 多签钱包

多签钱包是一种电子钱包，特点是交易被多个私钥持有者（多签人）授权后才能执行：例如
钱包由3个多签人管理，每笔交易需要至少2人签名授权。多签钱包可以防止单点
故障（私钥丢失，单人作恶），更加去中心化，更加安全，被很多DAO采用。

Gnosis Safe多签钱包是以太坊最流行的多签钱包，管理近400亿美元资产，合约经过审
计和实战测试，支持多链（以太坊，BSC，Polygon等），并提供丰富的DAPP支持。

#### 多签钱包合约

在以太坊上的多签钱包其实是智能合约，属于合约钱包。
1. 设置多签人和门槛(链上): 部署多签合约时，需要初始化多签人列表和执行门槛(至少n
	个多签人签名)
2. 创建交易: 一笔待授权的交易
3. 收集多签签名(链下): 将交易ABI编码并计算哈希得到交易哈希，然后让多签
	人签名，并拼接到一起得到打包签名。
4. 调用多签合约的执行函数，验证签名并执行交易（链上）


### MultisigWallet 

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// 基于签名的多签钱包，由gnosis safe合约简化而来
contract MultisigWallet {
    event ExecutionSuccess(bytes32 txHash);    // 交易成功事件
    event ExecutionFailure(bytes32 txHash);    // 交易失败事件

    address[] public owners;                   // 多签持有人数组
    mapping(address => bool) public isOwner;   // 记录一个地址是否为多签
    uint256 public ownerCount;                 // 多签持有人数量
    uint256 public threshold;                  // 多签执行门槛，交易至少有n个多签人签名才能被执行。
    uint256 public nonce;                      // nonce，防止签名重放攻击

    receive() external payable {}

    // 构造函数，初始化owners, isOwner, ownerCount, threshold
    constructor(
        address[] memory _owners,
        uint256 _threshold
    ) {
        _setupOwners(_owners, _threshold);
    }

    /// @dev 初始化owners, isOwner, ownerCount,threshold
    /// @param _owners: 多签持有人数组
    /// @param _threshold: 多签执行门槛，至少有几个多签人签署了交易
    function _setupOwners(address[] memory _owners, uint256 _threshold) internal {
        require(threshold == 0);
        require(_threshold <= _owners.length);
        require(_threshold >= 1);

        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            // 多签人不能为0地址，本合约地址，不能重复
            require(owner != address(0) && owner != address(this) && !isOwner[owner], "WTF5003");
            owners.push(owner);
            isOwner[owner] = true;
        }

        ownerCount = _owners.length;
        threshold = _threshold;
    }

    /// 在收集足够的多签签名后，执行交易
    function execTransaction(address to, uint256 value, bytes memory data, bytes memory signatures) public payable virtual returns (bool success) {
        bytes32 txHash = encodeTransactionData(to, value, data, nonce, block.chainid);
        nonce++;  
        checkSignatures(txHash, signatures); // 检查签名

        // 利用call执行交易，并获取交易结果
        (success, ) = to.call{value: value}(data);
        require(success);
        if (success) emit ExecutionSuccess(txHash);
        else emit ExecutionFailure(txHash);
    }

    // 检查签名和交易数据是否对应。如果是无效签名，交易会revert
    function checkSignatures(bytes32 dataHash, bytes memory signatures) public view {
        // 读取多签执行门槛
        uint256 _threshold = threshold;
        require(_threshold > 0);

        // 检查签名长度足够长
        require(signatures.length >= _threshold * 65);

        // 通过一个循环，检查收集的签名是否有效
        // 大概思路：
        // 1. 用ecdsa先验证签名是否有效
        // 2. 利用 currentOwner > lastOwner 确定签名来自不同多签（多签地址递增）
        // 3. 利用 isOwner[currentOwner] 确定签名者为多签持有人
        address lastOwner = address(0);
        address currentOwner;
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 i;
        for (i = 0; i < _threshold; i++) {
            (v, r, s) = signatureSplit(signatures, i);
            // 利用ecrecover检查签名是否有效
            currentOwner = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", dataHash)), v, r, s);
            require(currentOwner > lastOwner && isOwner[currentOwner], "WTF5007");
            lastOwner = currentOwner;
        }
    }

    /// 将单个签名从打包的签名分离出来
	// TODO
    function signatureSplit(bytes memory signatures, uint256 pos) internal pure returns (uint8 v, bytes32 r, bytes32 s) {
        // 签名的格式：{bytes32 r}{bytes32 s}{uint8 v}
        assembly {
            let signaturePos := mul(0x41, pos)
            r := mload(add(signatures, add(signaturePos, 0x20)))
            s := mload(add(signatures, add(signaturePos, 0x40)))
            v := and(mload(add(signatures, add(signaturePos, 0x41))), 0xff)
        }
    }

    // 编码交易数据
    function encodeTransactionData(address to, uint256 value, bytes memory data, uint256 _nonce, uint256 chainid) public pure returns (bytes32) {
        bytes32 safeTxHash = keccak256(abi.encode(to, value, keccak256(data), _nonce, chainid));
        return safeTxHash;
    }
}
```


