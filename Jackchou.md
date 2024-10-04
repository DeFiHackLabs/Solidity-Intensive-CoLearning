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
### 2024.09.28

- Value-typed variables can be declared as constant and immutable; string and bytes can be declared as constant, but not immutable.

- constant and immutable
constant
constant variable must be initialized during declaration and cannot be changed afterwards. Any modification attempt will result in error at compilation.
```
    // The constant variable must be initialized when declared and cannot be changed after that
    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0xAA";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```
Copy
- Immutable
- The immutable variable can be initialized during declaration or in the constructor, which is more flexible.
```
    // The immutable variable can be initialized in the constructor and cannot be changed later
    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;
```  
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Constant {
    // constant变量必须在声明的时候初始化，之后不能改变
    uint256 public constant CONSTANT_NUM = 10;
    string public constant CONSTANT_STRING = "0xAA";
    bytes public constant CONSTANT_BYTES = "WTF";
    address public constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

    // immutable变量可以在constructor里初始化，之后不能改变
    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;

    // 利用constructor初始化immutable变量，因此可以利用
    constructor(){
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_NUM = 1118;
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns(uint256){
        uint256 what = 9;
        return(what);
    }
}
```  
###

### 2024.09.29
if-else
function ifElseTest(uint256 _number) public pure returns(bool){
    if(_number == 0){
    return(true);
    }else{
    return(false);
    }
}

Copy
for loop
function forLoopTest() public pure returns(uint256){
    uint sum = 0;
    for(uint i = 0; i < 10; i++){
    sum += i;
    }
    return(sum);
}

Copy
while loop
function whileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    while(i < 10){
    sum += i;
    i++;
    }
    return(sum);
}

Copy
do-while loop
function doWhileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    do{
    sum += i;
    i++;
    }while(i < 10);
    return(sum);
}

Copy
Conditional (ternary) operator
The ternary operator is the only operator in Solidity that accepts three operands：a condition followed by a question mark (?), then an expression x to execute if the condition is true followed by a colon (:), and finally the expression y to execute if the condition is false: condition ? x : y.

This operator is frequently used as an alternative to an if-else statement.

// ternary/conditional operator
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
    // return the max of x and y
    return x >= y ? x: y; 
}

Copy
In addition, there are continue (immediately enter the next loop) and break (break out of the current loop) keywords that can be used.
###
###  2024.09.30
Events
The event in solidity are the transaction logs stored on the EVM (Ethereum Virtual Machine). They can be emitted during function calls and are accessible with the contract address. Events have two characteristics：

Responsive: Applications (e.g. ether.js) can subscribe and listen to these events through RPC interface and respond at frontend.
Economical: It is cheap to store data in events, costing about 2,000 gas each. In comparison, store a new variable on-chain takes at least 20,000 gas.
Declare events
The events are declared with the event keyword, followed by event name, then the type and name of each parameter to be recorded. Let's take the Transfer event from the ERC20 token contract as an example：

event Transfer(address indexed from, address indexed to, uint256 value);

Copy
Transfer event records three parameters: from，to, and value，which correspond to the address where the tokens are sent, the receiving address, and the number of tokens being transferred. Parameter from and to are marked with indexed keywords, which will be stored at a special data structure known as topics and easily queried by programs.

Emit events
We can emit events in functions. In the following example, each time the _transfer() function is called, Transfer events will be emitted and corresponding parameters will be recorded.
```
    // define _transfer function，execute transfer logic
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
###
### 2024.10.01
Inheritance
Inheritance is one of the core concepts in object-oriented programming, which can significantly reduce code redundancy. It is a mechanism where you can to derive a class from another class for a hierarchy of classes that share a set of attributes and methods. In solidity, smart contracts can be viewed objects, which supports inheritance.

Rules
There are two important keywards for inheritance in Solidity:

virtual: If the functions in the parent contract are expected to be overridden in its child contracts, they should be declared as virtual.

override：If the functions in the child contract override the functions in its parent contract, they should be declared as override
###
### 2024.10.02
Abstract contract
If a contract contains at least one unimplemented function (no contents in the function body {}), it must be labeled as abstract; Otherwise it will not compile. Moreover, the unimplemented function needs to be labeled as virtual. Take our previous Insertion Sort Contract as an example, if we haven't figured out how to implement the insertion sort function, we can mark the contract as abstract, and let others overwrite it in the future.
```
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```
###
### 2024.10.03
Errors
Solidity has many functions for error handling. Errors can occur at compile time or runtime.

Error
error statement is a new feature in solidity 0.8. It saves gas and informs users why the operation failed. It is the recommended way to throw error in solidity. Custom errors are defined using the error statement, which can be used inside and outside of contracts. Below, we created a TransferNotOwner error, which will throw an error when the caller is not the token owner during transfer:
###
### 2024.10.04
  start to read Solidity 102
  day11:
  [WTF Academy Solidity 102 16 Note](/content/jackchou/102.md)
###
<!-- Content_END -->
