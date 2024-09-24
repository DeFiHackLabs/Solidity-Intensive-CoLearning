---
timezone: Asia/Shanghai
---

# LikKee

1. 自我介绍

   > 2021 接触 Solidity，从合约到全端完成了 3 个 NFT 项目，ex-Tech lead 链游

2. 你认为你会完成本次残酷学习吗？
   > 必须的

## Notes

<!-- Content_START -->

### 2024.09.23

#### Chapter 1: Introduction

- `Solidity` is a programming language for Smart Contract development on EVM (Ethereum Virtual Machine).
- `Remix` is a browser-based IDE (Integrated Development Environment) for Solidity development, it have file management, compiler, deployment, interaction and various plugins available.
- A Solidity Smart Contract consists of 3 parts: License type, Solidity version and contract logics.

#### Chapter 2: Variables

- 3 types of Variable: Value, Reference and Mapping

- Value types:
  - `bool` Boolean
  - `uint` Unsigned integer
  - `int` Signed integer
  - `address` Address
  - `bytes` Variable-length bytes arrays
  - `byte` Fixed-length byt arrays
  - `enum` Enumeration

#### Chapter 3: Function

Format of a function

`function <function name>(<parameter types>) [public|private|external|internal] [pure|view|payable] [returns (<return types>)]`

- Function visibility specifiers

  - `public`: Accessible to all
  - `private`: Can only be called within this contract
  - `internal`: Can be called within this contract and contracts deriving from it
  - `external`: Can only be called by external

- Function behavior specifiers
  - `pure`: Cannot read or write state
  - `view`: Read only, doesn't change state
  - `payable`: Allow this function to receive native currency

#### Chapter 4: Function output

```
function testReturn() public pure returns (uint256) {
  return 1;
}
```

- `returns`: to indicate how many and what type of variable for output
- `return`: to output the desired value, and must matched to the `returns` requirements
- **Named returns**: Naming the output variables, eg:
  ```
  function testReturn() public pure returns (uint256 one, uint256 two) {
   one = 1;
   two = 2;
  }
  ```
- To **READ** variables return from function
  ```
  (uint256 one, uint256 two) = testReturn();
  ```
  or
  ```
  (, uint256 two) = testReturn();
  ```

### 2024.09.24

#### Chapter 5: Data Storage and Scope

- Data storage location:

  - `storage`: All state variables are `storage` by default, which are stored on-chain and consumes a lot of `gas`

    - `storage` can use to create as reference to a local variable, eg:

    ```
    uint256[] public x = [1,2,3]; // State variable

    functiuon refStorage() public {
      uint256[] storage ref = x;
      ref[0] = 0; // x's value resulted as: [0,2,3]
    }
    ```

  - `memory`: Variables temporarily stored in memory, for computation, consumes less `gas`

    - `memory` will create an in-memory reference that doesn't affect storage, eg:

    ```
    uint256[] public x = [1,2,3]; // State variable

    functiuon refStorage() public view {
      uint256[] memory ref = x;
      ref[0] = 0; // x's value remain unchanged: [1,2,3]
    }
    ```

  - `calldata`: Variables stored in memory but cannot be modified, generally used for function parameters.

- Variable scope
  - State variables: Delcared inside contract and outside the function
  ```
  contract Variables {
   uint256 public x = 1;
  }
  ```
  - Local variables: Variables inside the function, only valid during function execution
  ```
  function local() public pure {
   uint256 x = 1;
  }
  ```
  - Global variables: Reserved keywords in Solidity
    - `msg.sender`: Transaction sender
    - `block.number`: Current block height
    - `msg.data`: Transaction calldata
    - `blockhash(uint blockNumber)`: Hash of given block
    - `block.coinbase`: The address of current block miner
    - `block.gaslimit`: The gas limit of current block
    - `block.number`: Current block number
    - `block.timestamp`: The timestamp of current block
    - `gasleft()`: Remaining gas
    - `msg.sig`: First four bytes of calldata, i.e: function identifier
    - `msg.value`: Amount of `wei` in the transaction

#### Chapter 6: Array & Struct

- Reference type variables:

  - `array`

  ```
  uint256[] public x = [1,2,3];
  ```

  - `struct`

  ```
  struct Book {
     uint256 id;
     string title;
  }
  ```

  - `mapping`

- Array
  - Fixed-size arrays: Length of array specified during declaration
    `uint256[3] public x = [1,2,3];`
  - Variable-length array: Length of array is not specified during declaration
  ```
  uint256[] public x;
  bytes public b;
  ```
- Rules for creating arrays
  - For `memory` array, it must created with `new` operator, the length fixed during creatioin and cannot be changed:
  ```
  uint256[] memory x = new uint256[](3);
  ```
  - The type of first element in the array literal can be declared, otherwise the smallest storage type is used by default
  ```
  [uint(1), 2, 3]
  [1,2,3] // Default use uint8
  ```
  - Value of array assign one by one
  ```
  x[0] = 1;
  ...
  x[2]
  ```
- Features

  - `length`
  - `push()`: add `0` at the end of the array
  - `push(x)`: add `x` element at the end of the array
  - `pop()`: Remove the last element from the array

- Struct
  - Elements of `struct` can be primitive types or references types
  - `struct` can be the element for array and `mapping`
  - Ways to assign values to `struct`:
    - Method 1: Create a storage struct reference in the function
    ```
    function setBook() external {
      Book storage _book = book;
      _book.id = 1;
      _book.title = "Solidity Ascademy";
    }
    ```
    - Method 2: Directly refer to struct of state variable
    ```
    function setBook() external {
      book.id = 1;
      book.title = "Solidity Academy";
    }
    ```
    - Method 3: `struct` constructor
    ```
    function setBook() external {
      book = Book(1, "Solidity Academy");
    }
    ```
    - Method 4: Key value
    ```
    function setBook() external {
      book = Book({id: 1, title: "Solidity Academy"});
    }
    ```

#### Chapter 7: Mapping

- Mapping
  ```
  mapping(_KeyType => _ValueType)
  mapping(address => uint256) public balances; // Store balances of addresses
  ```
  - Rules of creating `mapping`
    - Rule 1: `_keyType` cannot be a custom `struct`, `_ValueType` can
    - Rule 2: Must be stored in `storage`, but it can't be used as variable in function or as return result
    - Rule 3: `mapping` declared as `public` will have a `getter` to query the value with key
    - Rule 4: Adding a key-value pair to a mapping is `var[newKey] = value`
  - Principle of `mapping`
    - Doesn't store `Key` or length information
    - Use `keccak256(abi.encodePacked(key, slot))` as offset to access value, where `slot` is the slot location where the mapping variable is defined
    - EVM define all unused space as `0`, the key of unassigned value will be `0`

### 2024.09.25

### 2024.09.26

### 2024.09.27

### 2024.09.28

### 2024.09.29

### 2024.09.30

### 2024.10.01

### 2024.10.02

### 2024.10.03

### 2024.10.04

### 2024.10.05

### 2024.10.06

### 2024.10.07

### 2024.10.08

### 2024.10.09

### 2024.10.10

<!-- Content_END -->
