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

### 2024.09.28

| Assignment type | Value change together? | 
|---|---|
| storage = storage | Y | 
| storage = memory | N |
| memory = storage | N | 
| memory = memory | Y |

**Key principle**: same data location then pass by reference

### 2024.10.01

#### Chapter 6: Array & Struct

- Arrays
   - Bytes array
      - `bytes1[]` - dynamic array of single bytes, e.g. [0x01, 0x02, 0x03]
      - `bytes` - cheaper, dynamic array of multiple bytes, e.g. 0x0102030405
   - `memory` arrays
      - array size fixed after creation, but can be dynamic at creation
      - e.g. `uint[2] memory a = [uint(1), 2]` or `uint[] memory a = new uint[](2)`

- struct
   
   ```solidity
   struct Student{
        uint256 id;
        uint256 score; 
   }

   Student student;

   function initStudent1() external{
      Student storage _student = student; // assign a copy of student
      _student.id = 11;
      _student.score = 100;
   }

   // Method 2: Directly refer to the struct of the state variable
   function initStudent2() external{
      student.id = 1;
      student.score = 80;
   }
   // Method 3: struct constructor
   function initStudent3() external {
      student = Student(3, 90);
   }
   
   // Method 4: key value
   function initStudent4() external {
      student = Student({id: 4, score: 60});
   }
   ```

### 2024.10.02

#### Chapter 7: Mapping

```solidity
mapping(uint => address) public idToAddress;
```

- key type can't be struct, but value can be anything
- must be `storage`
- auto getter function for public variable
- no length info beceause all unused keys have 0 value

### 2024.10.03

#### Chapter 8: Initial Value

- boolean: `false`
- string: `""`
- int: `0`
- uint: `0`
- enum: first element in enumeration
- address: `0x0000000000000000000000000000000000000000` (or `address(0)`)

```solidity
delete x; // change x to default value
```

### 2024.10.04

#### Chapter 9: Constant

- Constant
   - value-typed / reference-typed variables
   - must be initialized during declaration
- Immutable
   - value-typed only
   - can be initialized during declaration or in the constructor

<!-- Content_END -->
