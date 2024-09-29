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

### 2024.09.27

学了一下 solidity 中的函数调用的底层原理。solidity 中的函数调用有两种。

- 内部函数调用 (Internal Function Calls)：对于在同一个合约内直接通过函数名进行的调用，会被编译为 EVM 的跳转指令。因此这样的调用不会创建新的 context 环境，也不会改变 `msg.sender` (`caller()`) 的值。但依然会进行压栈操作，从而只能进行非常有限的递归。
- 外部函数调用 (External Function Calls)：对于使用 `<contract instance>.<function>` 进行的调用，会被编译为 EVM 的 `call` 指令。这样的调用会创建新的 context 环境，也会改变 `msg.sender` (`caller()`) 的值。

<<<<<<< HEAD
=======
### 2024.09.28

了解了一下合约中存储的实现。

声明在合约中的变量，通常被称为状态变量，保存在存储区 (storage)。由于存储区变量是保存在区块链上的，因此相比其他存储区域，它的读取和修改都非常昂贵，需要消耗更多的 gas。因此在设计上存储区的内存布局会较为紧凑。

> State variables of contracts are stored in storage in a compact way such that multiple values sometimes use the same storage slot. Except for dynamically-sized arrays and mappings (see below), data is stored contiguously item after item starting with the first state variable, which is stored in slot `0`. For each variable, a size in bytes is determined according to its type. Multiple, contiguous items that need less than 32 bytes are packed into a single storage slot if possible, according to the following rules:
>
> - The first item in a storage slot is stored lower-order aligned.
> - Value types use only as many bytes as are necessary to store them.
> - If a value type does not fit the remaining part of a storage slot, it is stored in the next storage slot.
> - Structs and array data always start a new slot and their items are packed tightly according to these rules.
> - Items following struct or array data always start a new storage slot.

mapping、array 等变长数据结构会使用 hash 确定真实的存储位置。

### 2024.09.29

在 Byzantium 升级之后，函数调用时的 `view` 修饰是由 evm 机制保证的，`STATICCALL` opcode 会将 evm 设置为 storage 只读状态。对于库函数，依然使用 `DELEGATECALL`。

> For library `view` functions `DELEGATECALL` is used, because there is no combined `DELEGATECALL` and `STATICCALL`. This means library `view` functions do not have run-time checks that prevent state modifications. This should not impact security negatively because library code is usually known at compile-time and the static checker performs compile-time checks.

>>>>>>> e174eb6 (Add YuKirasawa 09.29 notes)
<!-- Content_END -->
