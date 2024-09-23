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

<!-- Content_END -->
