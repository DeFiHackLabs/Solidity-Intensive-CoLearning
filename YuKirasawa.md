---
timezone: Asia/Shanghai
---

---

# YuKirasawa

1. 自我介绍

   近期刚接触智能合约和 solidity，希望多学习一些 solidity 的知识

2. 你认为你会完成本次残酷学习吗？

   会
## Notes

<!-- Content_START -->

### 2024.09.23

因为最近学了一点 solidity，就简单过了一遍 WTF Academy 101，以及学了一下 ETH 网络的交易编码方式

#### LegacyTransaction

LegacyTransaction 是原始的 ETH 交易类型，编码方式为 `rlp([nonce, gasPrice, gasLimit, to, value, data, v, r, s])`。其中

- 非 eip-155 交易的 v 为 `{0,1} + 27`，签名的输入为 6 元组 `(nonce, gasprice, startgas, to, value, data)` 的 rlp 编码的哈希

- eip-155 交易的 v 为 `{0,1} + CHAIN_ID * 2 + 35`，且签名的输入为 9 元组 `(nonce, gasprice, startgas, to, value, data, chainid, 0, 0)` 的 rlp 编码的哈希

可以通过 v 的值确定使用哪种方式验签

eip-2718 提出使用 `TransactionType || TransactionPayload` 的方式引入新的交易类型

#### EIP-2930 (TransactionType 1)

EIP-2930 引入了 Optional access lists，TransactionType 为 1

TransactionPayload 编码方式为 `rlp([chainId, nonce, gasPrice, gasLimit, to, value, data, accessList, signatureYParity, signatureR, signatureS])`

签名的输入为 `keccak256(0x01 || rlp([chainId, nonce, gasPrice, gasLimit, to, value, data, accessList]))`

#### EIP-1559 (TransactionType 2)

EIP-1559 引入了新的 gas 机制，TransactionType 为 2，目前的大部分交易都使用这种方式。

TransactionPayload 编码方式为 `rlp([chain_id, nonce, max_priority_fee_per_gas, max_fee_per_gas, gas_limit, destination, amount, data, access_list, signature_y_parity, signature_r, signature_s])`

签名的输入为 `keccak256(0x02 || rlp([chain_id, nonce, max_priority_fee_per_gas, max_fee_per_gas, gas_limit, destination, amount, data, access_list]))`

### 2024.09.24

简单过了一遍 WTF Academy 102，以及学了一下 ETH 网络的交易签名方式

ETH 交易的签名使用 ECDSA 签名算法，但与标准的 ECDSA 有一点点区别，签名使用 `(v, r, s)` 三元组，其中 `r, s` 的意义与 ECDSA 中相同，而 `v` 用于指示椭圆曲线上相同 x 坐标的两个对称点的确定一个。交易签名中并不显式含有发送者信息，发送者的公钥通过签名反推出来，再进一步得到发送者的地址。因此通过 `v` 可以确定唯一的公钥。

### 2024.09.25

学习了 103 ERC20。ERC20 是一个代币合约的标准，规定了一个代币合约的接口。包含如下逻辑：

- 账户余额(balanceOf())

- 转账(transfer())

- 授权转账(transferFrom())

- 授权(approve())

- 代币总供给(totalSupply())

- 授权转账额度(allowance())

以及可选的名称(name())，代号(symbol())，小数位数(decimals())

实现满足 ERC20 要求的函数和事件，就可以创建并发行一个 ERC20 代币。

### 2024.09.26

今天比较忙，简单看了一下 103 的代币水龙头。

<!-- Content_END -->
