---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加夏令时间 (UTC-8)

timezone: America/Los_Angeles # 太平洋夏令时间 (UTC-7)

timezone: America/Denver # 山地夏令时间 (UTC-6)

timezone: America/Chicago # 中部夏令时间 (UTC-5)

timezone: America/New_York # 东部夏令时间 (UTC-4)

timezone: America/Halifax # 大西洋夏令时间 (UTC-3)

timezone: America/St_Johns # 纽芬兰夏令时间 (UTC-2:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# YourName

1. 自我介绍
   
   学习 Solidity，想成为一名 Smart contract Auditor。

2. 你认为你会完成本次残酷学习吗？
   
   会。
   
## Notes

<!-- Content_START -->

### 2024.09.25
Day 3
WTF Academy Solidity 101 9-12

**Key Points**

9. Constant and Immutable
   
    - `immutable` variable can be initialized in the **constructor**;

10. Control Flow
11. Constructor & Modifier
    
    Constructor in inheritance
    
      ```solidity
         // father contract

         contract ImmutableState {
            
            IPoolManager public immutable poolManager;

            constructor(IPoolManager _poolManager) {
               poolManager = _poolManager;
            }
         }
         
         // 
         contract SafeCallback is ImmutableState {
            ...
            //using father contract's constructor
            constructor(IPoolManager _poolManager) ImmutableState(_poolManager) {} 
            ...
         }
         

      ```

    Modifier

      ``` solidity
         modifier onlyOwner {
            require(msg.sender == owner);
            _;
         }

         function changeOwner(address _newOwner) external onlyOwner {
            owner = _newOwner;
         }
      ```
12. Event
    ```solidity
      // define event
      event Transfer(address indexed from, address indexed to, uint256 value);
    
      // define _transfer function， execute transfer logic
      function _transfer(
         address from,
         address to,
         uint256 amount
      ) external {

         _balances[from] = 10000000; // give some initial tokens to transfer address

         _balances[from] -=  amount; // "from" address minus the number of transfer
         _balances[to] += amount; // "to" address adds the number of transfer

         // emit event
         emit Transfer(from, to, amount);
      }
    
    ```
    
    - Events can be seen as a cheap way to store data on-chain, like a database.
    - EVM Log
      - Topics 0: event signature(hash)
      - Topics 1: event indexed parameter0
      - Topics 2: event indexed parameter1
      ...
      - Data: value parameter in event
  
  
### 2024.09.24

Class WTF Academy Solidity 101 5-8

**Key Points**

Data Storage and Scope

Reference Type: `array`, `struct`

| Data location| Usage | location| Others|
| -- | -- | -- |--|
| `storage` | state variables|on-chain||
| `memory`| function parameters | memory, not on-chain|`string`, `bytes`, `array`|
| `calldata`|function parameters, cannot be modified |memory, not on-chain||

Assignment behaviour

| Assignment behaviour | Affect the original? |
|--|--|
| State variable (`storage`) -> local `storage` (in a function) | Yes |
| `storage` -> `memory`| Not|
| `memory` -> `memory`| Yes |
| variable -> `storage`| Not |

Variable scope
- State variables (very very important)
- Useful Global variable
  - `msg.sender` (`address payable`): Message sender (current caller)
  - `msg.value` (`bytes4`): number of wei sent with the message
  - `block.number` (`uint`): Current block number
  - `block.timestamp` (`uint`): The timestamp of the current block
  - `wei`: 1
  - `gwei`: 1e9 = 1000000000
  - `ether`: 1e18 = 1000000000000000000
  - `seconds`: 1
  - `minutes`: 60
  - `hours`: 3600
  - `days`: 86400
  - `weeks`: 604800
  
Array

```solidity
   uint[8] array1;
   bytes1[5] array2;
   address[100] array3;

   uint[] array4;
   bytes1[] array5;
   address[] array6;
   bytes array7;

   uint[] memory array8 = new uint[](5);
   bytes memory array9 = new bytes(9);
```

Struct
   - Pay more attention to the changes and impacts of the status of each element in the `struct` within the contract

Mapping
  - Very useful in smart contracts

  -  `_KeyType` should be default types: `uint`, `address`
  -  `_ValueType` can be any type
  -  `storage` location
     -  can as the state variable or `storage` variable inside function
     -  can not in arguments or return results of `public` function
  -  adding a key-value pair `_Var[_Key] = _Value`

```solidity


    mapping(address owner => mapping(address operator => bool isOperator)) public isOperator; // Two levels

    mapping(address owner => mapping(address spender => mapping(uint256 id => uint256 amount))) public allowance; // Three levels


```


### 2024.09.23

Class: WTF Academy Solidity 101 1-4

Key points：
- `address` size = 20 byte
- `address payable` with memebers `transfer` and `send`
- from `address` type to `payable address` type:  `payable(_address)`
- Fixed-length byte arrays: **value type**
- Variable-length byte arrays **reference type**
- Use cases of byte arrays
  1. Information encoding and decoding: Multiple pieces of information, suce as flags and status,can be encoded into a single byte arrays to save gas.
- Function
   ```solidity
         function <function name> (<parameter types>) [internal|external|public|private] [virtual|override|pure|view|payable] [returns (<return types>)]
   ```

   ```mermaid
      graph TD
         A[Start] --> B{Choose visibility modifier}
         B -->|Externally callable| C[external]
         B -->|Internally callable| D[internal]
         B -->|Callable both externally and internally| E[public]
         B -->|Only callable within current contract| F[private]
         
         C & D & E & F --> G{Requires Ether payment?}
         G -->|Yes| H[payable]
         G -->|No| I{Modifies state?}
         
         I -->|Yes| J[No additional modifier needed]
         I -->|No| K{Reads state?}
         
         K -->|Yes| L[view]
         K -->|No| M[pure]
         
         H & J & L & M --> N{Is it a base class function?}
         N -->|Yes| O[virtual]
         N -->|No| P{Overrides a base class function?}
         
         P -->|Yes| Q[override]
         P -->|No| R[End]
         
         O --> R
         Q --> R
   ```  
- return: Destructuring assignments
  
   ```
      // Named return, still support return
      function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
         return(1, true, [uint256(1),2,5]);
      }
      ...
      uint256 _number;
      bool _bool;
      uint256[3] memory _array;
      (_number, _bool, _array) = returnNamed();
      ...
      (, _bool2, ) = returnNamed();

  ```




<!-- Content_END -->
