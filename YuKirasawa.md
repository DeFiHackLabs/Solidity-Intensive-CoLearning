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

### 2024.09.30

合约的调用数据会被编码为字节串。其中前 4 字节为函数选择器 (Function Selector)，之后编码调用的参数。对于 staic 数据类型，会按顺序用 32 bytes 编码，对于 dynamic 数据类型，首先编码该数据的实际位置偏移，再在所有参数出现后编码实际数据。

常用函数：

- `abi.encode` 函数可以将若干变量按 abi 编码规则编码为 bytes

- `abi.encodeWithSignature` 会自动将第一个参数作为函数签名，计算函数选择器并进行编码

- `abi.encodeWithSelector` 直接将第一个参数为函数选择器进行编码

- `abi.encodePacked` 并不使用 abi 编码规则，而是将给定参数根据其所需最低空间编码，适用于自行打包数据为 bytes，可以用于数据拼接

- `abi.decode` 用于解码 `abi.encode` 生成的二进制编码，将它还原成原本的参数。

### 2024.10.01

#### ether 的发送方式

主要有三种方法可以发送 ether：`transfer`, `send` 和 `call`。由于 `transfer`, `send` 都不能调整 gas (均为 2300 gas 的定值)，目前仅推荐使用 `call`

同时，由于 `call` 没有对 gas 的严格限制，合约开发者需要通过代码上的设计避免重入攻击。

ether 主要有三种单位，转换比例为

```solidity
assert(1 wei == 1);
assert(1 gwei == 1e9);
assert(1 ether == 1e18);
```

发送和接收 ether 的示例代码如下

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
```

### 2024.10.02

今天学习了 103 的 35. 荷兰拍卖

### 2024.10.03

今天学习了 103 的 36. 默克尔树

<!-- Content_END -->
