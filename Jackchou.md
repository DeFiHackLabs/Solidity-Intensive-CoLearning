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

# JackChou

1. 自我介绍
   是個後端工程師, 在工作上有碰到一點合約ㄝ, 想要做WEB3工程師
2. 你认为你会完成本次残酷学习吗？
   會
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
- For this week, I will target on finishing solidity 101
- Finished solidity 101, 1-4
  - 3.function
    ```
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.4;
    contract Quiz3{
        // complete following funciton, let it return the sum of x and y
        function sum(uint x, uint y) pure external returns (uint sumXY){
            sumXY = x+y;
        }
    }
    ```
    output
    ```
    decoded input	{
      "uint256 x": "2",
      "uint256 y": "3"
    }
    decoded output	{
      "0": "uint256: sumXY 5"
    }
    ```
    - In Solidity, functions can be marked as `pure`, `view`, or `payable` to indicate their behavior. `pure` functions do not modify the contract's state, while `view` functions can read the state but not modify it. `payable` functions can receive Ether.
  - 4.function Output 
    - There are two keywords related to function output: return and returns:
    ```
    returns is added after the function name to declare variable type and variable name;
    return is used in the function body and returns desired variables.
        // returning multiple variables
        function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
                return(1, true, [uint256(1),2,5]);
            }
    ```
### 
### 2024.09.24
   - storage: The state variables are storage by default, which are stored on-chain.

  - memory: The parameters and temporary variables in the function generally use memory label, which is stored in memory and not on-chain.

  - calldata: Similar to memory, stored in memory, not on-chain. The difference from memory is that calldata variables cannot be modified, and is generally used for function parameters. Example
  - Variable scope
  There are three types of variables in Solidity according to their scope: state variables, local variables, and global variables.

   - Below are some commonly used global variables:

blockhash(uint blockNumber): (bytes32) The hash of the given block - only applies to the 256 most recent block.
block.coinbase : (address payable) The address of the current block miner
block.gaslimit : (uint) The gaslimit of the current block
block.number : (uint) Current block number
block.timestamp : (uint) The timestamp of the current block, in seconds since the unix epoch
gasleft() : (uint256) Remaining gas
msg.data : (bytes calldata) Complete calldata
msg.sender : (address payable) Message sender (current caller)
msg.sig : (bytes4) first four bytes of the calldata (i.e. function identifier)
msg.value : (bytes4) number of wei sent with the message

###
### 2024.09.25
An array is a variable type commonly used in Solidity to store a set of data (integers, bytes, addresses, etc.).

fixed-sized arrays: The length of the array is specified at the time of declaration. An array is declared in the format T[k], where T is the element type and k is the length.

Dynamically-sized array（dynamic array）：Length of the array is not specified during declaration. It uses the format of T[], where T is the element type.

  - only storage can use dynamic array
  In Solidity, the `push` method can only be used on dynamic arrays that are stored in storage, not on arrays that are stored in memory. The reason for this is that `push` is a mutating operation that modifies the underlying storage, which is not allowed on memory variables.

  - To fix this issue, you can create a new dynamic array in storage and copy the elements from the original array into the new one, like this:

  ```solidity
  function initArray() external pure returns(uint[] memory){
    uint[] memory x = new uint[](3);
    x[0] = 1;
    x[1] = 3;
    x[2] = 4;
    uint[] memory array55 = new uint[](x.length + 1);
    for (uint i = 0; i < x.length; i++) {
        array55[i] = x[i];
    }
    array55[array55.length - 1] = 3;
    return array55;
  }
  ```
###
### 2024.09.26
  - Mapping
  - With mapping type, people can query the corresponding Value by using a Key. For example, a person's wallet address can be queried by their id
```
// define a struct
      struct Student{
          uint256 id;
          uint256 score;
      }
      mapping(Student => uint) public testVar;
```
- Rule 2: The storage location of the mapping must be storage: it can serve as the state variable or the storage variable inside function. But it can't be used in arguments or return results of public function.

Rule 3: If the mapping is declared as public then Solidity will automatically create a getter function for you to query for the Value by the Key.

Rule 4：The syntax of adding a key-value pair to a mapping is _Var[_Key] = _Value, where _Var is the name of the mapping variable, and _Key and _Value correspond to the new key-value pair. For example:
```
 function writeMap (uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
      }
```
###
### 2024.09.27
  - init value
  - boolean: false
    string: ""
    int: 0
    uint: 0
    enum: first element in enumeration
    address: 0x0000000000000000000000000000000000000000 (or address(0))
    function
    internal: blank function
    external: blank function
    ```
        bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet {Buy, Hold, Sell}
    ActionSet public _enum; // first element 0

    function fi() internal{} // internal blank function
    function fe() external{} // external blank function
    ```
    - Initial values of reference types
mapping: a mapping which all members set to their default values

struct: a struct which all members set to their default values

array

dynamic array: []
static array（fixed-length): a static array where all members set to their default values.
You can use getter function of public variables to confirm initial values:
```
    // reference types
    uint[8] public _staticArray; // a static array which all members set to their default values[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`
    mapping(uint => address) public _mapping; // a mapping which all members set to their default values
    // a struct which all members set to their default values 0, 0
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student;

```
### 
<!-- Content_END -->
