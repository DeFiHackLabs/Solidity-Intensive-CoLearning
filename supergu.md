---
timezone: Asia/Shanghai
---

# SuperGu🐧

1. 自我介绍

   大家好，我是SuperGu，進幣圈已差不多八年了，但從未認真學過Solidity，現在是時候了！

2. 你认为你会完成本次残酷学习吗？

   當然，LFG!
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### Chapter 1: HelloWeb3

- 3 basic element of a solidity file:

   1. Software license `// SPDX-License-Identifier: MIT`
   2. Compiler version `pragma solidity ^0.8.4;`
   3. Contract content `contract HelloWeb3{ ... }`

### 2024.09.24

#### Chapter 2: Value Type

- Variable types
   - Value
      1. Boolean
      2. Integers 
      3. Addresses
      4. Fixed-size byte arrays
      5. Enumeration
   - Reference
   - Mapping
   - Function

- Integers
   - `int`, `uint`, `uint256` (256-bit +ve int)

- Addresses

   ```solidity
   // Address
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address (can transfer fund and check balance)
    // Members of address
    uint256 public balance = _address1.balance; // balance of address
    _address1.transfer(1); // transfer 1 wei to _address1
    ```

- Enumeration

   ```solidity
   // Let uint 0,  1,  2 represent Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // Create an enum variable called action
    ActionSet action = ActionSet.Buy;
   ```

<!-- Content_END -->
