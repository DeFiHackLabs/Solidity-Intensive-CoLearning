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

### 2024.09.25

#### Chapter 3: Function

- Basic syntax of function: `function <function name>(<parameter types>) [internal|external|public|private] [pure|view|payable] [returns (<return types>)]`

- `[internal|external|public|private]`

   - `public`: Visible to all.

   - `private`: Can only be accessed within this contract, derived contracts cannot use it.

   - `external`: Can only be called from other contracts. But can also be called by `this.f()` inside the contract, where `f` is the function name.

   - `internal`: Can only be accessed internal and by contracts deriving from it.

- `[pure|view|payable]`

   - `pure`: can't read or write, gas free

   - `view`: can read, can't write, gas free

   - default is can read and can write

   - `payable`: can send ETH to the contract via this function

#### Chapter 4: Function

- Unnamed return

   ```solidity
   function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
      return(1, true, [uint256(1),2,5]);
   }
   ```

- Named return

   ```solidity
   function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        _number = 2;
        _bool = false; 
        _array = [uint256(3),2,1]; // Casting required otherwise default is int. Other values no need because interpreter infer from the data type of the first value
    }
   ```

- Destructuring assignments

   ```solidity
   (_number, _bool, _array) = returnNamed();
   (, _bool2, ) = returnNamed(); // dropping 2 returned values
   ```

### 2024.09.26

#### Chapter 5: Data Storage and Scope

- Data location

   - `storage`: default, stored on-chain, expensive gas
   - `memory`: temp variables used in function, cheaper gas
   - `calldata`: `memory` that can't be modified

- Only applicable to Reference variable types: `array`, `struct` and `mapping`

<!-- Content_END -->
