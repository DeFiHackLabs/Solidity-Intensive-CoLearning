---
timezone: Asia/Shanghai

---

# Jason

1. 自我介绍 - Web3 lawyer

2. 你认为你会完成本次残酷学习吗？ 會
   
## Notes

<!-- Content_START -->
### 2024.09.23
1. 複習Solidity 101
2. 資源筆記：（a） Solidity中文文档（[官方文档的中文翻译](https://docs.soliditylang.org/zh/v0.8.19/index.html)）(b) [崔棉大师solidity教程](https://space.bilibili.com/286084162) (c) [Solidity 入門走到飛](https://www.youtube.com/watch?v=X135KO-8OTg)
3. structure
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
4. Variables
   (a) 值类型(Value Type)： These variables directly pass values when assigned
         ■ Boolean: A binary variable with values of true or false.
         ■ Integers: Signed (int) and unsigned (uint) integers, storing up to 256-bit integers.
         ■ Addresses: Holds a 20-byte Ethereum address, with address payable allowing ETH transfers.
         ■ Fixed-size byte arrays: byte, bytes8, bytes32, etc., with a fixed length declared at initialization.
         ■ Enumeration (enum): User-defined data types that assign names to uint values for readability
   (b) 引用类型(Reference Type)：These variables store the address of data and can be modified with different variable names:
         ■ Arrays: Used to store a set of data. Can be fixed-size (T[k]) or dynamically-sized (T[]).
         ■ Structs: User-defined data types that group together variables of different types.
         ■ Variable-length byte arrays: bytes, with a length that can be modified after declaration
   (c) 映射类型(Mapping Type): Solidity中存储键值对的数据结构，可以理解为哈希表

### 

<!-- Content_END -->

<!-- Content_START -->
### 2024.09.24


### 

<!-- Content_END -->
