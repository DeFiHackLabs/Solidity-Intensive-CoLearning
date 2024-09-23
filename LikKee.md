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

##### Chapter 1: Introduction

- `Solidity` is a programming language for Smart Contract development on EVM (Ethereum Virtual Machine).
- `Remix` is a browser-based IDE (Integrated Development Environment) for Solidity development, it have file management, compiler, deployment, interaction and various plugins available.
- A Solidity Smart Contract consists of 3 parts: License type, Solidity version and contract logics.

##### Chapter 2: Variables

- 3 types of Variable: Value, Reference and Mapping

- Value types:
  - `bool` Boolean
  - `uint` Unsigned integer
  - `int` Signed integer
  - `address` Address
  - `bytes` Variable-length bytes arrays
  - `byte` Fixed-length byt arrays
  - `enum` Enumeration

###### Chapter 3: Function

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
  - `payable`: Allow contract to receive native currency

###### Chapter 4: Function output

```
function testReturn() public pure returns (uint256) {
  return 1;
}
```

- `returns` used to indicate how many and what type of variable for output
- `return` used to output the desired value, and must matched to the `returns` requirements
- Named returns: Naming the output variables, eg:
  ```
  function testReturn() public pure returns (uint256 one, uint256 two) {
   one = 1;
   two = 2;
  }
  ```
- To read variables return from function
  ```
  (uint256 one, uint256 two) = testReturn();
  ```
  or
  ```
  (, uint256 two) = testReturn();
  ```

### 2024.09.24

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
